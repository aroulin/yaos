# yaos
Yet Another Operating System

## Goal
Implement a simple & portable kernel

## Steps
1. Hello World bootsector
2. Load kernel from disk (bootloader)
3. Enter protected mode
4. Drivers for simple peripherals
  * screen
  * keyboard
  * timers
5. Implements various parts of standard library
  * string functions (strlen, memcpy, ...)
  * memory allocation (malloc, free, ...)
  * stdio functions (printf, scanf, ...)
6. Write a bare metal game
7. Userspace and system calls
