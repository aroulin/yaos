boot1
=====

+ Goal: switch from 16-bit real-mode to 64-bit long-mode

# Switching from real-mode to protected-mode

+ Make sure the A20 line is enabled (to access addresses past 1MB)
+ Check that low legacy memory is indeed 640KB
+ Print available high memory
+ load a GDT from memory with full 4GB code/data segments
    + Base = 0
    + Limit = 4GB
    + Granularity = 4KB
    + Size = 32-bit protected mode
+ Set PE (Protection Enable) bit in CR0
+ Load CS and DS with code and data segment descriptors

# Switch from protected-mode to real-mode

+ Setup 3-level page table
+ PM4L located at 0x10000
+ PDPT located at 0x11000
+ PDT located at at 0x12000
+ Load CR3 with PM4L address

+ Enable long mode in model-specific register
+ Set paging bit in CR0
+ switch to long-mode loading new GTD and reload CS descriptor cache