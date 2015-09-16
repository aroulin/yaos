ifeq ($(shell uname), Darwin)

hdd.img: boot.S
	as $< -arch i386 -o boot.o
	gobjcopy -O binary boot.o $@
else

hdd.img: boot.S
	as $< -o boot.o
	ld -Ttext 0x7c00 boot.o -o boot.out
	ld --oformat binary -Ttext 0x7c00 boot.o -o hdd.img
endif

qemu: hdd.img
	qemu-system-i386 -hda hdd.img

dbg: hdd.img
	qemu-system-i386 -hda hdd.img -S -s &
	gdb

disassemble:
	objdump -m i8086 -M intel -D boot.out

clean:
	rm -rf boot.o hdd.img boot.out

.PHONY: qemu dbg disassemble clean
