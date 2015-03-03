set architecture i8086
b *0x7c00
target remote localhost:1234
c
layout asm
layout regs
