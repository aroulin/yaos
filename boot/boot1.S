.code16
.text

.global _start
_start:
    mov $msg, %si
    call bios_print
    jmp .
msg:
    .asciz "It's crazy ! Boot 1 got called...\r\n"
