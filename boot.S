.intel_syntax noprefix

.code16				/* 16-bit real-mode code here */
.text

.equ REAL_MODE_SP, 0x7000

.global _start
_start:
	cli
	jmp 0,setup
setup:
	# Zero the segment registers
	xor ax, ax
	mov ds, ax 
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	# Setup stack
	mov sp, REAL_MODE_SP

	# Enable back interrupts
	sti

	# Save drive number
	mov [drive_number], dl

# Hello World through BIOS interrupts
hello_world:
	mov ah, 0x0e		# Function no 0x0e is print a char
	mov  si, offset str_hw
loop:
	lodsb
	cmp al, 0
	jz halt
	int 0x10
	jmp loop

halt:
	jmp .

str_hw:
	.asciz "Hello World!"

drive_number:
	.byte 0

	.=510			# MBR Magic Number
	.byte 0x55
	.byte 0xAA
