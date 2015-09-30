.code16
.text

# Return in ax the size in KB of the low memory (only RAM)
# including the BIOS IVT, BIOS Data Area and Extended BIOS Data Area
.global low_mem_size
low_mem_size:
    int $0x12
    inc %ax # Add 1KB of Extended Bios Data Area (not included by BIOS call)
    ret