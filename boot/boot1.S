.intel_syntax noprefix
.code16
.global _start
_start:
	mov si, offset msg
	call bios_print
	jmp .
msg:
	.asciz "It's crazy ! Boot 1 got called...\r\n"
