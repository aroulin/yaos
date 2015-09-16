.intel_syntax noprefix

.code16				/* 16-bit real-mode code here */
.text

.equ REAL_MODE_SP, 0x7000
.equ BOOT1_START, 0x1000

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

	# Reset disk drive
	mov ah, 0
	int 0x13
	jc print_error
	mov si, offset str_disk_reset
	call print

	# Read boot1 in the next 17 sectors
	mov ah, 2
	mov al, 17
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov bx, BOOT1_START
	int 0x13
	jc print_error
	cmp al, 17
	jne print_error

	jmp BOOT1_START
print:
	mov ah, 0x0e # Function no 0x0e is print a char
print_loop:
	lodsb
	cmp al, 0
	jz print_end
	int 0x10
	jmp print_loop
print_end:
	ret

# Hello World through BIOS interrupts
print_error:
	mov  si, offset str_error
	call print
	jmp halt

halt:
	jmp .

str_disk_reset:
	.asciz "Disk resetted successfully\r\n"

str_error:
	.asciz "Error :("

drive_number:
	.byte 0

	.=510			# MBR Magic Number
	.byte 0x55
	.byte 0xAA
