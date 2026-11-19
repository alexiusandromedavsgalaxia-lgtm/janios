# NEXUS 12

A browser-based desktop environment inspired by modern operating systems. NEXUS 12 is an independent web project, not a Microsoft product.

## Run locally
```bash
npm install
npm run dev
```

## Features
- First-run setup wizard and simulated local account sign-in
- Desktop, taskbar, Start menu, draggable/resizable windows
- Settings, themes, wallpaper selection and display preferences
- File manager, Notes, Calculator, Calendar, Clock, Terminal
- Built-in browser with NEXUS-owned pages and external URL navigation
- Alternate Fireworks AI browser (configure endpoint and API key in Settings)
- App Center with installable `.react` app packages

## .react package format
A `.react` file is a JSON app manifest rendered by the NEXUS component runtime. It is not arbitrary executable JavaScript.

```json
{
  "format": "nexus-react-app",
  "version": 1,
  "id": "hello-world",
  "name": "Hello World",
  "icon": "✨",
  "description": "A sample app",
  "screen": {
    "type": "column",
    "children": [
      { "type": "heading", "text": "Hello from NEXUS" },
      { "type": "text", "text": "This app was installed from a .react package." }
    ]
  }
}
```

Installed app manifests are stored locally in the browser. This is a web desktop simulation, not a bootable operating system. Microsoft sign-in is simulated and does not authenticate with Microsoft. Fireworks connectivity requires a compatible endpoint and a user-provided API key.
