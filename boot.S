.code16				/* 16-bit real-mode code here */
.text
	movw	$0xB800, %ax	/* 0xB000 is the text screen video memory */
	movw	%ax, %es	/* set it as the %es segment */

	movb	$'A, %es:0x0	/* screen[0] = 'A' */
	movb	$0x07, %es:0x1  /* white on black */
	jmp	.

	.=510			/* MBR Magic Number */
	.byte	0x55
	.byte	0xaa
