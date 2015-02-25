hdd.img: boot.S
	as $< -o boot.o
	objcopy -O binary boot.o $@

qemu:
	qemu-system-i386 -hda hdd.img

clean:
	rm -rf boot.o hdd.img
