# JanOS architecture and implementation plan

## Product boundary

JanOS has three distinct deliverables:

1. **JanOS Kernel**: an independent ARM64 operating-system kernel.
2. **JanOS Mobile Shell**: the phone UI and system applications, eventually running as native userspace services on top of the kernel.
3. **JanOS Web Edition**: a browser-based companion/demo. A browser cannot boot or replace a phone kernel.

The existing Qt Quick application is currently a UI prototype. It must not be described as the kernel or as a complete operating system.

## Kernel design

| Layer | Responsibility | Status |
|---|---|---|
| AArch64 entry | Boot entry, stack and BSS setup | Initial QEMU bring-up |
| Console | PL011 serial output on QEMU virt | Initial QEMU bring-up |
| Exceptions | Vector table, synchronous faults, IRQ/FIQ | Planned |
| Memory | Physical page allocator, virtual address spaces, MMU | Planned |
| Scheduler | Preemptive tasks and context switching | Planned |
| IPC | Message channels and shared memory | Planned |
| VFS | Mounts, file descriptors and filesystem drivers | Planned |
| Drivers | Device tree, interrupts, timers, storage, display, touch, radio | Planned |
| Security | Process isolation, capabilities, verified packages and secure boot | Planned |

## Native app format

The proposed `.janpkg` is a ZIP container with:

- `manifest.json`: package ID, display name, version, minimum API, entry module and permissions.
- `app.wasm`: WebAssembly application module.
- `assets/`: icons, strings and other read-only resources.

The package manager must validate the manifest, check API/dependency compatibility, verify a publisher signature, request declared permissions and install atomically. The WebAssembly runtime and signing infrastructure are future work; package recognition alone does not mean an app can execute yet.

## Android app compatibility

Android applications are APKs and expect Android framework APIs, Android Runtime (ART), Bionic, Binder, graphics/input services and other platform components. The independent JanOS kernel does not automatically provide these.

The compatibility track must be investigated separately. A realistic route is to port or integrate appropriately licensed Android userspace components and provide Linux-compatible kernel interfaces where required. Compatibility will be device- and API-version-dependent. No promise of universal APK support is made.

## Android phone port

The first hardware target must be selected before producing a flashable image. A phone port needs:
- exact SoC and board revision;
- bootloader and boot image format;
- device tree and reserved memory map;
- interrupt controller, timer and clock drivers;
- display, touch, storage, USB and power management;
- verified boot/signing constraints and a tested recovery route.

Until these are available, the supported bring-up target is QEMU ARM64, not a physical phone.
