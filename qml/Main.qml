import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    visible: true
    width: 390
    height: 844
    minimumWidth: 320
    minimumHeight: 560
    title: "JanOS 15"
    color: "#10182d"

    property bool controlCenterOpen: false
    property bool appDrawerOpen: false
    property bool settingsOpen: false
    property bool darkMode: true
    property int wallpaperIndex: 0

    readonly property var wallpapers: [
        ["#152b62", "#7c4d9b", "#f08a85"],
        ["#073b4c", "#118ab2", "#8bd3dd"],
        ["#35204a", "#8d4a74", "#f2a07b"]
    ]

    function showToast(message) {
        toastLabel.text = message
        toast.opacity = 1
        toastTimer.restart()
    }

    Timer {
        id: toastTimer
        interval: 1700
        onTriggered: toast.opacity = 0
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: window.wallpapers[window.wallpaperIndex][0] }
            GradientStop { position: 0.55; color: window.wallpapers[window.wallpaperIndex][1] }
            GradientStop { position: 1.0; color: window.wallpapers[window.wallpaperIndex][2] }
        }
    }

    // Decorative soft-focus wallpaper shapes.
    Rectangle {
        width: parent.width * 0.95
        height: width
        radius: width / 2
        x: parent.width * 0.35
        y: parent.height * 0.12
        rotation: -18
        color: "#35ffffff"
        opacity: 0.22
    }
    Rectangle {
        width: parent.width * 0.8
        height: width
        radius: width / 2
        x: -parent.width * 0.32
        y: parent.height * 0.42
        color: "#5b8fd5"
        opacity: 0.22
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 22
        anchors.rightMargin: 22
        anchors.topMargin: 9
        anchors.bottomMargin: 18
        spacing: 0

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            Text {
                text: Qt.formatTime(new Date(), "h:mm")
                color: "white"
                font.pixelSize: 15
                font.weight: Font.DemiBold
            }
            Item { Layout.fillWidth: true }
            Text { text: "●  ▮▮▮  ▰"; color: "white"; font.pixelSize: 12 }
            Text { text: "  98%"; color: "white"; font.pixelSize: 12; font.weight: Font.DemiBold }
        }

        Item { Layout.preferredHeight: 25 }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 92
            radius: 23
            color: "#25ffffff"
            border.color: "#35ffffff"
            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 12
                Rectangle {
                    width: 52; height: 52; radius: 17
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#68e0cf" }
                        GradientStop { position: 1; color: "#3579dc" }
                    }
                    Text { anchors.centerIn: parent; text: "J"; color: "white"; font.pixelSize: 31; font.weight: Font.Bold }
                }
                ColumnLayout {
                    spacing: 3
                    Text { text: "Welcome to JanOS"; color: "white"; font.pixelSize: 16; font.weight: Font.Bold }
                    Text { text: "Your mobile space, your rules."; color: "#e7e9f6"; font.pixelSize: 12 }
                }
            }
        }

        Item { Layout.preferredHeight: 25 }

        GridLayout {
            Layout.fillWidth: true
            columns: 4
            rowSpacing: 22
            columnSpacing: 12

            Repeater {
                model: [
                    ["☎", "Phone", "#38bd83"],
                    ["✉", "Messages", "#3289ed"],
                    ["▧", "Photos", "#f2b64c"],
                    ["◉", "Camera", "#68758a"],
                    ["◉", "Browser", "#3c9ce8"],
                    ["♫", "Music", "#e85c85"],
                    ["☼", "Weather", "#55b8d8"],
                    ["⚙", "Settings", "#78869b"]
                ]
                delegate: Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 88
                    property string appName: modelData[1]
                    Column {
                        anchors.centerIn: parent
                        spacing: 7
                        Rectangle {
                            width: 55; height: 55; radius: 16
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: modelData[2]
                            border.color: "#45ffffff"
                            Text {
                                anchors.centerIn: parent
                                text: modelData[0]
                                color: "white"
                                font.pixelSize: 28
                                font.weight: Font.Medium
                            }
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: modelData[1]
                            color: "white"
                            font.pixelSize: 11
                            style: Text.Outline
                            styleColor: "#35000000"
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (appName === "Settings") window.settingsOpen = true
                            else window.showToast(appName + " · demo app")
                        }
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 86
            radius: 27
            color: "#35ffffff"
            border.color: "#40ffffff"
            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 15
                Repeater {
                    model: [["☎", "#38bd83", "Phone"], ["◉", "#3c9ce8", "Browser"], ["✉", "#3289ed", "Messages"], ["▦", "#f0a94a", "Library"]]
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 17
                        color: modelData[1]
                        Text { anchors.centerIn: parent; text: modelData[0]; color: "white"; font.pixelSize: 27 }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: window.showToast(modelData[2] + " · dock")
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: 35
            Rectangle {
                width: 112; height: 4; radius: 2
                color: "white"; opacity: 0.9
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: window.appDrawerOpen = !window.appDrawerOpen
            }
        }
    }

    // Quick settings panel.
    Rectangle {
        anchors.fill: parent
        visible: window.controlCenterOpen
        color: "#b90b1020"
        z: 5
        MouseArea { anchors.fill: parent; onClicked: window.controlCenterOpen = false }
        Rectangle {
            width: parent.width - 28
            height: 330
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 12
            radius: 30
            color: "#edf1f8"
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                Text { text: "Control Center"; color: "#172033"; font.pixelSize: 22; font.weight: Font.Bold }
                GridLayout {
                    Layout.fillWidth: true
                    columns: 2
                    Repeater {
                        model: ["Airplane mode", "Wi-Fi", "Bluetooth", "Do not disturb"]
                        delegate: Button {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 65
                            text: modelData
                            onClicked: window.showToast(modelData + " toggled")
                        }
                    }
                }
                Slider { Layout.fillWidth: true; from: 0; to: 1; value: 0.8 }
                Slider { Layout.fillWidth: true; from: 0; to: 1; value: 0.65 }
                Item { Layout.fillHeight: true }
                Button { Layout.alignment: Qt.AlignRight; text: "Done"; onClicked: window.controlCenterOpen = false }
            }
        }
    }

    // App drawer overlay.
    Rectangle {
        anchors.fill: parent
        visible: window.appDrawerOpen
        z: 6
        radius: 28
        color: "#f3f5fa"
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 22
            Text { text: "App Library"; color: "#172033"; font.pixelSize: 27; font.weight: Font.Bold }
            TextField { Layout.fillWidth: true; placeholderText: "Search apps"; }
            GridLayout {
                Layout.fillWidth: true
                columns: 3
                Repeater {
                    model: ["Phone", "Messages", "Photos", "Camera", "Browser", "Music", "Weather", "Settings", "Clock"]
                    delegate: Button {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 65
                        text: modelData
                        onClicked: {
                            window.appDrawerOpen = false
                            if (modelData === "Settings") window.settingsOpen = true
                            else window.showToast(modelData + " · demo app")
                        }
                    }
                }
            }
            Item { Layout.fillHeight: true }
            Button { Layout.alignment: Qt.AlignRight; text: "Close"; onClicked: window.appDrawerOpen = false }
        }
    }

    // Settings sheet.
    Rectangle {
        anchors.fill: parent
        visible: window.settingsOpen
        z: 7
        color: "#f4f6fb"
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            RowLayout {
                Text { text: "Settings"; color: "#172033"; font.pixelSize: 30; font.weight: Font.Bold }
                Item { Layout.fillWidth: true }
                Button { text: "Done"; onClicked: window.settingsOpen = false }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 70
                radius: 18
                color: "#ffffff"
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 13
                    Rectangle {
                        width: 43; height: 43; radius: 14
                        color: "#347fdf"
                        Text { anchors.centerIn: parent; text: "J"; color: "white"; font.pixelSize: 25; font.bold: true }
                    }
                    ColumnLayout {
                        Text { text: "JanOS User"; color: "#172033"; font.bold: true; font.pixelSize: 15 }
                        Text { text: "JanOS 15 · Preview"; color: "#687386"; font.pixelSize: 12 }
                    }
                }
            }
            Switch {
                text: "Dark appearance"
                checked: window.darkMode
                onToggled: window.darkMode = checked
            }
            Text { text: "Wallpaper"; color: "#172033"; font.pixelSize: 18; font.bold: true }
            RowLayout {
                Repeater {
                    model: 3
                    delegate: Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 70
                        radius: 15
                        gradient: Gradient {
                            GradientStop { position: 0; color: window.wallpapers[index][0] }
                            GradientStop { position: 1; color: window.wallpapers[index][2] }
                        }
                        border.width: window.wallpaperIndex === index ? 3 : 0
                        border.color: "#347fdf"
                        MouseArea { anchors.fill: parent; onClicked: window.wallpaperIndex = index }
                    }
                }
            }
            Text { text: "About"; color: "#172033"; font.pixelSize: 18; font.bold: true }
            Text { text: "JanOS 15\nVersion 0.1.0\nAn independent mobile UI experiment."; color: "#687386"; font.pixelSize: 13; lineHeight: 1.35 }
            Item { Layout.fillHeight: true }
        }
    }

    // Top-edge gesture target opens the quick panel.
    MouseArea {
        z: 10
        x: 0; y: 0
        width: parent.width
        height: 12
        onClicked: window.controlCenterOpen = true
    }

    Rectangle {
        id: toast
        z: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 58
        width: Math.min(toastLabel.implicitWidth + 34, parent.width - 40)
        height: 42
        radius: 21
        color: "#e91b2233"
        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 180 } }
        Text {
            id: toastLabel
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 13
            text: ""
        }
    }
}
