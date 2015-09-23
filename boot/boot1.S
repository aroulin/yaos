.code16
.text

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
    jmp .

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
