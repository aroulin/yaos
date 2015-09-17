.code16 # 16-bit real-mode code here
.text

.equ REAL_MODE_SP, 0x7000
.equ BOOT1_START, 0x1000

.global _start
_start:
    cli
    ljmp $0, $setup
setup:
    # Zero the segment registers
    xor %ax, %ax
    mov %ax, %ds 
    mov %ax, %es
    mov %ax, %fs
    mov %ax, %gs
    mov %ax, %ss

    # Setup stack
    mov $REAL_MODE_SP, %sp

    # Enable back interrupts
    sti

    # Save drive number
    mov %dl, drive_number

    # Reset disk drive
    mov $0, %ah
    int $0x13
    jc print_error
    mov $str_disk_reset, %si
    call print

    # Read boot1 in the next 17 sectors
    mov $2, %ah
    mov $17, %al
    mov $0, %ch
    mov $2, %cl
    mov $0, %dh
    mov $BOOT1_START, %bx
    int $0x13
    jc print_error
    cmp $17, %al
    jne print_error

    jmp BOOT1_START

print:
    mov $0x0e, %ah # Function no 0x0e is print a char
print_loop:
    lodsb
    cmp $0, %al
    jz print_end
    int $0x10
    jmp print_loop
print_end:
    ret

# Hello World through BIOS interrupts
print_error:
    mov str_error, %si
    call print
    jmp halt

halt:
    jmp .

str_disk_reset:
    .asciz "Disk resetted successfully\r\n"

str_error:
    .asciz "Error :("

drive_number:
    .byte 0

    .=510 # MBR Magic Number
    .byte 0x55
    .byte 0xAA
