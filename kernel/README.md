# JanOS Independent Kernel

This directory starts the independent JanOS kernel track. It is deliberately separate from the Qt/QML phone-interface prototype.

## Current milestone: AArch64 bare-metal bring-up

The first target is **QEMU virt on AArch64**, which gives JanOS a repeatable ARM64 machine while the real Android phone target is being researched. The initial kernel is freestanding C++ with a tiny AArch64 entry point and PL011 serial output.

This is a kernel bring-up milestone, **not yet an Android-flashable image**. Android phones need device-specific boot-image integration, a compatible boot chain, device tree, memory layout, clocks, interrupts, storage, display, touch, power and vendor drivers. Those pieces must be implemented and tested per supported device.

## Build

Use an AArch64 bare-metal toolchain (for example `aarch64-none-elf-gcc/g++`) and CMake:

```sh
cmake -S kernel -B build/kernel -DCMAKE_TOOLCHAIN_FILE=cmake/aarch64-none-elf.cmake
cmake --build build/kernel
```

The toolchain file is a template and may need adjustment for the compiler installed on your machine.

Run with QEMU when available:

```sh
qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -kernel build/kernel/janos-kernel.elf
```

Expected serial banner: `JanOS kernel: ARM64 bring-up`.

## Planned layers

- **Kernel core:** exception/interrupt handling, physical and virtual memory, scheduler, IPC, system calls and VFS.
- **Device model:** device tree discovery and drivers behind stable interfaces.
- **JanOS native apps:** `.janpkg` packages containing a manifest and WebAssembly module, subject to a future sandboxed runtime.
- **Android compatibility:** a separate userspace compatibility project. APK support requires Android framework/runtime components and a compatible Linux/Bionic environment; it is not provided by this bare-metal milestone.
- **Phone port:** device-specific boot image, drivers and verified recovery/rollback path before any real-device installation.

See [ARCHITECTURE.md](ARCHITECTURE.md) for the roadmap and constraints.
