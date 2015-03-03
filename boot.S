.code16				/* 16-bit real-mode code here */
.text

.global _start
_start:
	jmp $0,$setup
setup:
	/* Zero the segment registers */
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss

/* Hello World through BIOS interrupts. */
hello_world:
	movb $0x0e, %ah		/* Function no 0x0e is print a char. */
	mov $str_hw, %si
loop:
	lodsb
	cmpb $0, %al
	jz halt
	int $0x10
	jmp loop

halt:
	jmp .

str_hw:
	.asciz "Hello World!"

	.=510			/* MBR Magic Number */
	.byte 0x55
	.byte 0xAA
