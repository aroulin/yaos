LEVEL = ..

boot.bin: boot0.bin boot1.bin
	cat boot0.bin boot1.bin > boot.bin
boot0.bin: boot0.o
	ld --oformat binary -Ttext 0x7c00 boot0.o -o boot0.bin
boot1.bin: boot1.o boot1_main.o $(LEVEL)/lib/realmode/librealmode.a
	ld --oformat binary -Ttext 0x1000 $^ -o boot1.bin
	truncate -s 8704 boot1.bin
disassemble: boot0.o boot1.o
	ld -Ttext 0x7c00 boot0.o -o boot0.out
	ld -Ttext 0x1000 boot1.o -o boot1.out
	objdump -m i8086 -M intel -D boot0.out
	objdump -m i8086 -M intel -D boot1.out

clean:
	rm -rf *.o *.bin *~ *.out *.a

include $(LEVEL)/Makefile.rules
