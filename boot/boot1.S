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

    jmp .

a20_gate_enabled_str:
    .asciz "A20 gate is enabled\r\n"
a20_gate_disabled_str:
    .asciz "A20 gate is disabled\r\n"
