all: boot0.bin boot1.bin
	cat boot0.bin boot1.bin > boot.bin
boot0.bin: boot0.o
	ld --oformat binary -Ttext 0x7c00 boot0.o -o boot0.bin
boot1.bin: boot1.o
	ld --oformat binary -e _boot1_start -Ttext 0x1000 boot1.o -o boot1.bin
%.o: %.S
	as $*.S -o $@

clean:
	rm -rf *.o *.bin *~
