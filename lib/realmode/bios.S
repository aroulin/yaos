.intel_syntax noprefix
.code16

.global bios_print

bios_print:
    mov ah, 0x0e
bios_print_loop:
    lodsb
    cmp al, 0
    jz bios_print_end
    int 0x10
    jmp bios_print_loop
bios_print_end:
    ret
