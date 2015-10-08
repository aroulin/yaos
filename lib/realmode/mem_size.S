.code16
.text

# Return in ax the size in KB of the low memory (only RAM)
# including the BIOS IVT, BIOS Data Area and Extended BIOS Data Area
.global low_mem_size
low_mem_size:
    int $0x12
    inc %ax # Add 1KB of Extended Bios Data Area (not included by BIOS call)
    ret

# Return in ax the size in MB of the high memory (only RAM)
# High memory size retrieved is a lower bound approximation
.global high_mem_size
high_mem_size:
    pusha

    mov $0xE820, %eax    # Query System Address Map
    mov $0, %ebx         # First call
    mov $20, %ecx        # addr_range_desc size (in bytes)
    mov signature, %edx  # Signature
    mov $addr_range_desc, %di

    # First call will give low memory (640KB)
    int $0x15

high_mem_size_loop:
    # While not last valid descriptor
    mov $0xE820, %eax
    cmp $0, %ebx
    je high_mem_size_end

    # Get next descriptor
    int $0x15

    # If it's RAM
    cmpl $1, Type
    jne high_mem_size_loop

    # Add sizes to accumulators
    mov LengthLow, %eax
    add %eax, high_mem_size_acc_low
    mov LengthHigh, %eax
    adc %eax, high_mem_size_acc_high
    jmp high_mem_size_loop

high_mem_size_end:
    popa
    mov high_mem_size_acc_low, %eax
    shr $20, %eax
    mov high_mem_size_acc_high, %edx
    shl $12, %edx
    add %edx, %eax
    ret

high_mem_size_acc_low:
    .int 0
high_mem_size_acc_high:
    .int 0

signature:
    .ascii "PAMS"       # SMAP signature little-endian

addr_range_desc:
BaseAddrLow:
    .int 0
BaseAddrHigh:
    .int 0
LengthLow:
    .int 0
LengthHigh:
    .int 0
Type:
    .int 0
