.section .text.boot, "ax"
.global _start
.type _start, %function

_start:
    // Accept either EL2 or EL1 entry. The phone port must validate the
    // actual bootloader hand-off for each supported device.
    mrs x2, CurrentEL
    cmp x2, #0x8
    b.ne 1f

    // Enter AArch64 EL1h when firmware starts the payload at EL2.
    mov x2, #0x80000000
    msr hcr_el2, x2
    mov x2, #0x3
    msr cnthctl_el2, x2
    msr cntvoff_el2, xzr
    mov x2, #0x3c5
    msr spsr_el2, x2
    adr x2, 1f
    msr elr_el2, x2
    eret

1:
    ldr x0, =__stack_top
    mov sp, x0

    // Clear the zero-initialized data region.
    ldr x0, =__bss_start
    ldr x1, =__bss_end
2:
    cmp x0, x1
    b.hs 3f
    str xzr, [x0], #8
    b 2b
3:
    bl kernel_main

4:
    wfe
    b 4b

.size _start, . - _start
