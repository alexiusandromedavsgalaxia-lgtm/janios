# JanOS

JanOS is an independent mobile operating-system project with three separate tracks:

- **Independent kernel:** freestanding C++20 and AArch64 bring-up under `kernel/`.
- **Mobile shell prototype:** C++20, Qt 6 and Qt Quick (QML), on `main`.
- **Web edition:** HTML, CSS and JavaScript, on the `webb` branch in `web/`. This is a browser companion, not a bootable OS.

## Independent kernel status

The first kernel milestone targets **QEMU virt on ARM64**. It includes an AArch64 entry point, stack/BSS initialization, a linker layout and PL011 serial output. The intended serial banner is `JanOS kernel: ARM64 bring-up`.

Build instructions, architecture boundaries and the Android port plan are in [kernel/README.md](kernel/README.md) and [kernel/ARCHITECTURE.md](kernel/ARCHITECTURE.md).

**Important:** the kernel has not been compiled or boot-tested here. It is not yet a flashable Android image and does not yet contain a scheduler, memory manager, drivers, filesystem, app runtime or Android compatibility layer. QEMU ARM64 is the initial bring-up target; a real phone requires a specific supported model and device-specific bootloader, device tree and drivers.

## Mobile shell prototype

The Qt Quick prototype currently contains:
- Home screen, status bar, app grid and dock
- Lock screen, notification shade, Control Center and recent-app switcher
- First-run setup assistant and persistent setup preferences
- Basic appearance and wallpaper controls

Build with Qt 6.4 or later, CMake 3.21 or later, and a matching desktop or Android Qt kit. For a desktop preview:

```sh
cmake -S . -B build
cmake --build build
```

For Android, install the Qt Android kit and Android SDK/NDK, then open the project in Qt Creator and deploy using the Android kit. This deploys the current shell prototype as an Android app; it does not install the independent kernel.

## Application compatibility plan

- **JanOS native apps:** the proposed `.janpkg` format uses a JSON manifest, a WebAssembly entry module and packaged assets. The example manifest is in `kernel/apps/manifest.example.json`. A secure package manager and sandboxed runtime are not implemented yet.
- **Android apps:** APK compatibility requires Android userspace/framework and runtime components, plus the necessary kernel interfaces. It is a separate future compatibility track and is not provided by the initial bare-metal kernel.
- **Apple apps:** iOS/iPadOS IPA packages are not supported. They rely on Apple's platform, signing and runtime infrastructure.

## Repository layout

```
janios/
├── kernel/       # Independent AArch64 kernel bring-up
├── src/          # Qt mobile-shell entry point
├── qml/          # Qt Quick mobile-shell UI
└── web/          # Browser companion on branch webb
```

JanOS is an independent project and is not affiliated with Apple or Google. It does not include proprietary iOS or Android source code.
