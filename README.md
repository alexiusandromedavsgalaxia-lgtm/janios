# JanOS 15

JanOS is an independent mobile-interface project with two coordinated implementations.

- **Mobile:** C++20, Qt 6 and Qt Quick (QML), on the `main` branch.
- **Web:** HTML, CSS and JavaScript, on the `webb` branch in `web/`.

The two editions share the same design direction, app set, navigation concepts and setup preferences. JanOS is an original interface project, not an operating-system replacement.

> JanOS is not affiliated with Apple and does not contain Apple's proprietary iOS source code or assets.

## Mobile prototype

Implemented components:
- Home screen, status bar, app grid and dock
- Lock screen, notification shade, Control Center and recent-app switcher
- First-run setup assistant with welcome, language/region, simulated Wi-Fi, privacy choices, device name and completion
- Setup preferences persisted using Qt Settings
- Wallpaper selection and basic appearance controls
- C++20 application entry point with Qt Quick/QML

Build with Qt 6.4 or later, CMake 3.21 or later, and a matching desktop or Android Qt kit. For a desktop preview:

```bash
cmake -S . -B build
cmake --build build
```

For Android, install the Qt Android kit and Android SDK/NDK, then open the project in Qt Creator and deploy using the Android kit.

## Web prototype

Open `web/index.html` in a modern browser or publish the `web/` directory as a static site. It includes the first-run setup flow, home screen, app previews, settings pages, Control Center, notifications, lock screen and local preference storage.

## Important limitations

This is still a prototype, not a production operating system. Wi-Fi and Bluetooth controls are simulated; camera, telephony, messages, weather data, native permissions, app installation, secure accounts, updates and hardware integration are not implemented. The project has not yet been compiled and device-tested in this workspace.

## Layout

```
janios/
├── CMakeLists.txt
├── README.md
├── src/
├── qml/
└── web/
```
