.code16
.text

#define BIT(x) (1 << x)

.global _start
_start:
    call a20_gate_is_enabled
    cmp $1, %ax
    je a20_gate_enabled

a20_gate_disabled:
    mov $a20_gate_disabled_str, %si
    call bios_print
    hlt

a20_gate_enabled:
    mov $a20_gate_enabled_str, %si
    call bios_print

goodbye_damn_realmode:
    cli

    # load the GDT
    lgdt (GDTR)

    mov %cr0, %eax
    or $1, %eax
    mov %eax, %cr0

    ljmp $0x10, $protected_mode

protected_mode:
.code32
    # Set data segment for the following data writes
    .equ DATA_SEG_SELECTOR, (1 << 3) # (index in GDT) << 3
    mov $DATA_SEG_SELECTOR, %eax
    mov %eax, %ds

    # Paging defines
    .equ PG_PRESENT, BIT(0) # Page present
    .equ PG_R_W, BIT(1) # Page is readable and writable 
    .equ PG_PS, BIT(7) # Page is the final page frame

    # Setup PM4L
    .equ PM4L, 0x10000 # PM4L address
    .equ PM4LE, PDPT + PG_PRESENT + PG_R_W # PM4L entry
    .equ PM4LE_HI, (PM4LE >> 32) & 0xFFFFFFFF
    .equ PM4LE_LO, PM4LE & 0xFFFFFFFF
    movl $PM4LE_LO, PM4L
    movl $PM4LE_HI, PM4L+4

    # Setup PDPT
    .equ PDPT, 0x11000 # PDPT address
    .equ PDPE, PDT + PG_PRESENT + PG_R_W # PDP entry
    .equ PDPE_HI, (PDPE >> 32) & 0xFFFFFFFF
    .equ PDPE_LO, PDPE & 0xFFFFFFFF
    movl $PDPE_LO, PDPT
    movl $PDPE_HI, PDPT+4

    # Setup PDT
    .equ PDT, 0x12000 # PDT address
    .equ PDE, PG_PRESENT + PG_R_W + PG_PS # PD entry
    .equ PDE_HI, (PDE >> 32) & 0xFFFFFFFF
    .equ PDE_LO, PDE & 0xFFFFFFFF
    movl $PDE_LO, PDT
    movl $PDE_HI, PDT+4

    # Set CR3 to PM4L
    mov $PM4L, %eax
    mov %eax, %cr3

    # Enable PAE
    .equ CR4_PAE, BIT(5)
    mov %cr4, %eax
    or $CR4_PAE, %eax
    mov %eax, %cr4

    # Enable Long Mode
    .equ IA32_EFER, 0xC0000080
    .equ IA32_EFER_LME, BIT(8)
    mov $IA32_EFER, %ecx
    rdmsr
    or $IA32_EFER_LME, %eax
    wrmsr

    # Enable paging -> Enter IA32e mode
    .equ CR0_PG, BIT(31)
    mov %cr0, %eax
    or $CR0_PG, %eax
    mov %eax, %cr0

    # Reload CS descriptor cache
    lgdt GDTR64
    pushw $0x10
    mov $long_mode_cs_reloaded, %eax
    push %eax
    lret

long_mode_cs_reloaded:
.code64
    sti
    call boot1_main
    cli
    hlt

a20_gate_enabled_str:
    .asciz "A20 gate is enabled\r\n"
a20_gate_disabled_str:
    .asciz "A20 gate is disabled\r\n"
GDTR:
    .word GDT_end - GDT - 1 #limit
    .long GDT                #base
GDT:
    .quad 0x0000000000000000  #null segment descriptor
    .quad 0x00DF92000000FFFF  #data segment descriptor
    .quad 0x00DF9A000000FFFF  #code segment descriptor
GDT_end:

GDTR64:
    .word GDT_end64 - GDT64 - 1 #limit
    .quad GDT64                #base
GDT64:
    .quad 0x0000000000000000  #null segment descriptor
    .quad 0x00BF92000000FFFF  #data segment descriptor
    .quad 0x00BF9A000000FFFF  #code segment descriptor
GDT_end64:
