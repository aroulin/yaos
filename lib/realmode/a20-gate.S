.code16

# Check if the A20 gate for the 20th address line is enabled
# Return 1 in ax if the A20 gate is enabled, else 0
.global a20_gate_is_enabled
a20_gate_is_enabled:
    push %si
    push %di
    push %ds
    push %es

    # ds:si = 0x0000:0x00 = 0x0
    # es:di = 0xFFFF:0x10 = a20 gate enabled ? 0x100000 : 0x0
    mov $0x0000, %ax
    mov %ax,%ds
    mov $0x00, %si
    mov $0xFFFF, %ax
    mov %ax, %es
    mov $0x10, %di

    # Save value at 0xFFFF:0x10 on stack
    push %es:(%di)

    # Compare bytes stored at both logical addresses
    movb %es:(%di), %al
    cmpb %al, (%si)
    # If these are different, then A20 gate is enabled
    jne a20_gate_enabled

    # Else they are the same and we need another test:
    # Store new value at 0xFFFF:0x10 and check if
    # address 0x100000 (1MB) is aliased to address 0
    inc %al
    movb %al, %es:(%di)
    cmpb %al, (%si)
    je a20_gate_disabled

a20_gate_enabled:
    mov $1, %ax
    jmp a20_gate_end

a20_gate_disabled:
    mov $0, %ax

a20_gate_end:
    # Restore value at 0xFFFF:0x10 from stack
    pop %es:(%di)

    pop %es
    pop %ds
    pop %di
    pop %si
    ret
