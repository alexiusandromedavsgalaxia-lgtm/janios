.section .text.boot, "ax"
.global _start
.type _start, %function

_start:
    // The first QEMU bring-up assumes entry at EL1.
    // A real phone port must implement and validate its bootloader hand-off.
    ldr x0, =__stack_top
    mov sp, x0

    // Clear the zero-initialized data region.
    ldr x0, =__bss_start
    ldr x1, =__bss_end
1:
    cmp x0, x1
    b.hs 2f
    str xzr, [x0], #8
    b 1b
2:
    bl kernel_main

3:
    wfe
    b 3b

.size _start, . - _start
