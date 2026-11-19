# JanOS 15

JanOS is an independent mobile-interface project with two coordinated implementations:

- **Mobile:** C++20 with Qt 6 and Qt Quick (QML), in the `main` branch.
- **Web:** HTML, CSS and JavaScript, in the `webb` branch under `web/`.

The visual language, app names, navigation model and settings concepts are designed to stay aligned across both editions. JanOS is an original project, not an operating-system replacement.

> JanOS is not affiliated with Apple and does not contain Apple's proprietary iOS source code or assets.

## Web edition

Open `web/index.html` in a modern browser or publish the repository's `web/` directory as a static site.

Current web prototype:
- First-run setup assistant: welcome, language/region, simulated Wi-Fi, privacy choices, device name and completion
- Home screen, app grid and dock
- App previews for Phone, Messages, Photos, Camera, Browser, Music, Weather, Clock, Files, Calendar and Search
- Settings pages for profile, appearance, network, notifications, privacy, language/region, lock screen and About
- Wallpaper and dark/light appearance preferences
- Control Center, notification shade, recent-app switcher and lock screen
- Local preference persistence using browser local storage
- Responsive phone-sized layout and touch navigation

Network radios, camera, telephony, messaging services, weather data and native operating-system permissions are placeholders. The web edition cannot control hardware or replace Android/iOS.

## Mobile edition

The mobile implementation uses C++20, Qt 6 Quick/QML and CMake. Install Qt 6 with the Android kit and Android SDK/NDK, then open the project in Qt Creator and select an Android Qt kit.

For a desktop preview:
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
├── qml/
└── web/
    ├── index.html
    ├── styles.css
    ├── app.js
    └── manifest.webmanifest
```

## Status

The web edition is a functional interface prototype. The mobile edition is a Qt/QML prototype. Neither has been compiled and device-tested as a production operating system yet; hardware integration, secure user accounts, real networking, app installation, permissions, updates and full accessibility remain future engineering work.
