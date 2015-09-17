hdd.img: lib.sub boot.sub
	cp boot/boot.bin hdd.img

%.sub:
	$(MAKE) -C $*

qemu: hdd.img
	qemu-system-i386 -hda hdd.img

dbg: hdd.img
	qemu-system-i386 -hda hdd.img -S -s &
	gdb

disassemble:
	objdump -m i8086 -M intel -b binary -D hdd.img

clean:
	$(MAKE) -C boot clean
	$(MAKE) -C lib clean
	rm -rf hdd.img *~

.PHONY: qemu dbg disassemble clean
