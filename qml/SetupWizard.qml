import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: wizard
    anchors.fill: parent
    color: "#f4f6fb"
    signal completed(string language, string region, string deviceName,
                     bool diagnostics, bool notificationsEnabled, bool wifiEnabled)
    property int page: 0
    property string selectedLanguage: "English"
    property string selectedRegion: "Spain"
    property bool diagnosticsEnabled: false
    property bool notificationsEnabled: true
    property bool wifiEnabled: true

    readonly property var titles: [
        "Welcome to JanOS", "Language & Region", "Connect to Wi-Fi",
        "Privacy first", "Make it yours", "You're all set"
    ]
    readonly property var subtitles: [
        "A fresh start. Your device, your choices.",
        "Choose how JanOS should speak to you.",
        "Choose a demo network state for this prototype.",
        "Decide which optional diagnostics are enabled.",
        "Give your device a name.",
        "Your JanOS space is ready."
    ]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 14

        RowLayout {
            Layout.fillWidth: true
            Text { text: "J"; color: "#347fdf"; font.pixelSize: 20; font.bold: true }
            Item { Layout.fillWidth: true }
            Text { text: "JANOS SETUP"; color: "#687386"; font.pixelSize: 11; font.bold: true; letterSpacing: 1.2 }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 4
            radius: 2
            color: "#dce2ec"
            Rectangle {
                width: parent.width * ((wizard.page + 1) / 6)
                height: parent.height
                radius: 2
                color: "#347fdf"
            }
        }

        Text {
            Layout.fillWidth: true
            text: wizard.titles[wizard.page]
            color: "#172033"
            font.pixelSize: 29
            font.bold: true
            wrapMode: Text.WordWrap
        }
        Text {
            Layout.fillWidth: true
            text: wizard.subtitles[wizard.page]
            color: "#687386"
            font.pixelSize: 14
            wrapMode: Text.WordWrap
        }

        Item { Layout.fillHeight: true; visible: wizard.page === 0 || wizard.page === 5 }
        Rectangle {
            visible: wizard.page === 0 || wizard.page === 5
            Layout.alignment: Qt.AlignHCenter
            width: 94; height: 94; radius: 28
            gradient: Gradient {
                GradientStop { position: 0; color: "#68e0cf" }
                GradientStop { position: 1; color: "#3579dc" }
            }
            Text {
                anchors.centerIn: parent
                text: wizard.page === 0 ? "J" : "✓"
                color: "white"
                font.pixelSize: 54
                font.bold: true
            }
        }
        Text {
            visible: wizard.page === 0 || wizard.page === 5
            Layout.fillWidth: true
            text: wizard.page === 0
                  ? "Let's prepare your device in a few quick steps. You can change these choices later in Settings."
                  : "Your preferences are ready. Select Start using JanOS to enter your home screen."
            color: "#687386"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
        ColumnLayout {
            visible: wizard.page === 1
            Layout.fillWidth: true
            Label { text: "Language"; color: "#172033" }
            ComboBox {
                id: languageBox
                Layout.fillWidth: true
                model: ["English", "Español", "Français", "Deutsch"]
                currentIndex: 0
                onActivated: wizard.selectedLanguage = currentText
            }
            Label { text: "Region"; color: "#172033" }
            ComboBox {
                id: regionBox
                Layout.fillWidth: true
                model: ["Spain", "United Kingdom", "United States", "France", "Germany"]
                currentIndex: 0
                onActivated: wizard.selectedRegion = currentText
            }
        }
        ColumnLayout {
            visible: wizard.page === 2
            Layout.fillWidth: true
            Button {
                Layout.fillWidth: true
                text: "⌁   JanOS Guest  ·  secured demo network"
                highlighted: wizard.wifiEnabled
                onClicked: wizard.wifiEnabled = true
            }
            Button {
                Layout.fillWidth: true
                text: "Skip for now"
                highlighted: !wizard.wifiEnabled
                onClicked: wizard.wifiEnabled = false
            }
            Label {
                Layout.fillWidth: true
                text: "This prototype cannot change your device's real Wi-Fi connection."
                color: "#687386"
                wrapMode: Text.WordWrap
            }
        }
        ColumnLayout {
            visible: wizard.page === 3
            Layout.fillWidth: true
            Switch {
                text: "Share anonymous usage diagnostics"
                checked: wizard.diagnosticsEnabled
                onToggled: wizard.diagnosticsEnabled = checked
            }
            Switch {
                text: "Allow notifications in JanOS"
                checked: wizard.notificationsEnabled
                onToggled: wizard.notificationsEnabled = checked
            }
            Label {
                Layout.fillWidth: true
                text: "You can change these preferences at any time."
                color: "#687386"
                wrapMode: Text.WordWrap
            }
        }
        ColumnLayout {
            visible: wizard.page === 4
            Layout.fillWidth: true
            Label { text: "Device name"; color: "#172033" }
            TextField {
                id: deviceName
                Layout.fillWidth: true
                text: "JanOS User"
                placeholderText: "Your device name"
                maximumLength: 28
            }
            Label {
                text: "This name is stored in JanOS settings."
                color: "#687386"
            }
        }
        Item { Layout.fillHeight: true }
        RowLayout {
            Layout.fillWidth: true
            Button {
                visible: wizard.page > 0
                text: "Back"
                onClicked: wizard.page = Math.max(0, wizard.page - 1)
            }
            Item { Layout.fillWidth: true }
            Button {
                highlighted: true
                text: wizard.page === 5 ? "Start using JanOS" : "Continue"
                onClicked: {
                    if (wizard.page === 1) {
                        wizard.selectedLanguage = languageBox.currentText
                        wizard.selectedRegion = regionBox.currentText
                    }
                    if (wizard.page === 4 && deviceName.text.trim().length === 0)
                        deviceName.text = "JanOS User"
                    if (wizard.page === 5) {
                        wizard.completed(wizard.selectedLanguage, wizard.selectedRegion,
                                         deviceName.text.trim().length ? deviceName.text.trim() : "JanOS User",
                                         wizard.diagnosticsEnabled, wizard.notificationsEnabled,
                                         wizard.wifiEnabled)
                    } else {
                        wizard.page += 1
                    }
                }
            }
        }
        Text {
            Layout.fillWidth: true
            text: "STEP " + (wizard.page + 1) + " OF 6"
            color: "#8791a3"
            font.pixelSize: 10
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
