ifeq ($(shell uname), Darwin)

hdd.img: boot.S
	as $< -arch i386 -o boot.o
	gobjcopy -O binary boot.o $@
else

hdd.img: boot.S
	as $< -o boot.o
	objcopy -O binary boot.o $@
endif

qemu:
	qemu-system-i386 -hda hdd.img

clean:
	rm -rf boot.o hdd.img
