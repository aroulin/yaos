.intel_syntax
.code16



.globl num2string

# Very simplified formatter for 16-bit unsigned numbers.
# Input param: ax (the unsigned number), bx (the base)
# Output param: di, null terminated
num2string:
	pusha

	xor cx, cx

num2string_loop:
	xor dx, dx
	div bx # now ax = num/base and dx = num % base

	cmp dl, 9
	ja num2string_A_off
	add dl, '0'
	jmp num2string_store

num2string_A_off:
	sub dl, 10
	add dl, 'A'

num2string_store:
	mov [di], dl
	inc di
	inc cx

	cmp ax, 0
	jnz num2string_loop

	xor bx, bx
	mov [di], bx

	# now we just have to reverse the buffer
	mov bx, di # bx = base + strlen
	sub bx, cx # bx = base

num2string_rev_loop:
	mov al, [bx]
	mov ah, [di - 1]
	xchg al, ah
	mov [bx], al
	mov [di - 1], ah

	dec di
	inc bx

	cmp di, bx
	ja num2string_rev_loop

	popa
	ret
