boot0
=====

+ Placed in the very first sector of the secondary storage (hard drive, USB drive, floppy disk, ...).
+ Size of a sector = 512 bytes, terminated by 0xAA -- 0x55 *Boot signature*.
+ BIOS loads it in memory at linear address 0x7C00 with in register DL the drive number from which it was loaded.

Setup stuff
===========

+ boot0 is loaded at linear address 0x7C00 but the logical address is not canonical among different BIOSes. A long jump canonicalizes it
to logical address 0x0:0x7C00.
+ Zero all segment registers
+ Setup stack at 0x7000 growing towards lower addresses

Load boot1
==========

+ load boot1 to linear address 0x1000 from sectors 2 to 18 from the drive.
+ jmp to boot1