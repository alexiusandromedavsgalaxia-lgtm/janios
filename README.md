# JanOS 15

JanOS 15 is an original mobile interface project written in C++ with Qt 6 and Qt Quick (QML). It takes inspiration from the clean, layered visual language of early-2020s mobile operating systems while using its own name, logo, icons, colors, and implementation.

> JanOS is an independent project and is not affiliated with Apple. It does not contain Apple's proprietary iOS source code or assets.

## Current starter features
- Full-screen mobile home screen
- Original JanOS "J" mark and app icon set
- Status bar with live clock
- App grid and dock
- Swipe-up style app drawer interaction
- Control Center panel with interactive demo toggles
- Lock screen with clock, date and unlock action
- Notification shade with sample notification cards
- Recent-app switcher with selectable app cards
- Settings panel with theme and wallpaper controls
- Responsive layouts for portrait mobile screens

## Stack
- C++20
- Qt 6 (Core, Gui, Quick, Qml)
- Qt Quick Controls
- CMake

## Build
Install Qt 6 with the Android kit and Android SDK/NDK, then open this project in Qt Creator. Select an Android Qt kit and build/deploy to a device.

For a desktop preview, configure with a desktop Qt 6 kit:
```bash
cmake -S . -B build
cmake --build build
```

## Project layout
```
janios/
├── CMakeLists.txt
├── README.md
├── src/main.cpp
└── qml/Main.qml
```

## Roadmap
1. Add richer settings pages and persistent preferences
2. Build individual demo app screens (Phone, Messages, Photos, Camera, Browser)
3. Improve touch gestures and accessibility
4. Add Android packaging configuration and device testing
5. Add real app lifecycle only where supported by the host platform
