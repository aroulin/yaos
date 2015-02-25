        .code16                 /* 16-bit real-mode code here */
        .text

        /* Print a char through BIOS interrupts. */
print_A:
        movb $0x0e, %ah         /* Function no 0x0e is print a char. */
        movb $'A, %al
        int $0x10
        jmp print_A


        .=510                   /* MBR Magic Number */
        .byte 0x55
        .byte 0xAA
