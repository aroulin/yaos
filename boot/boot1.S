.intel_syntax noprefix
.code16
.global _start
_start:
	mov si, offset msg
	call print
	jmp .
msg:
	.asciz "It's crazy ! Boot 1 got called...\r\n"

print:
	mov ah, 0x0e
print_loop:
	lodsb
	cmp al, 0
	jz print_end
	int 0x10
	jmp print_loop
print_end:
	ret
.=512*17
