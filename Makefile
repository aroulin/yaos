LEVEL = .

hdd.img: lib
	$(MAKE) -C boot
	cp boot/boot.bin hdd.img

lib:
	$(MAKE) -C lib

qemu: hdd.img
	qemu-system-x86_64 -drive file=hdd.img,format=raw

dbg: hdd.img
	qemu-system-x86_64 -drive file=hdd.img,format=raw -s &

disassemble:
	objdump -m i8086 -b binary -D hdd.img

clean:
	$(MAKE) -C boot clean
	$(MAKE) -C lib clean
	$(MAKE) -C tests clean
	rm -rf hdd.img *~

test: lib
	$(MAKE) -C tests
	./tests/test

.PHONY: lib qemu dbg disassemble clean

include $(LEVEL)/Makefile.rules
