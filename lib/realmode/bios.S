.code16

.global bios_print

bios_print:
    mov $0x0e, %ah
bios_print_loop:
    lodsb
    cmp $0, %al
    jz bios_print_end
    int $0x10
    jmp bios_print_loop
bios_print_end:
    ret
