# YAOS
*YAOS* (standing for *Yet Another Operating System*) is a kernel built from scratch. 

## Goal
Implement a simple & portable kernel

## Philosophy
- Avoid tutorials, do the work yourself.
- Understand the internals.
- Keep It Simple Stupid.

## Steps
1. Hello World bootsector
2. Load kernel from disk (bootloader)
3. Enter protected mode and then long mode
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
