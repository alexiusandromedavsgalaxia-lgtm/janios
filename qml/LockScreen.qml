import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: lock
    anchors.fill: parent
    signal unlocked()

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "#10234a" }
            GradientStop { position: 0.55; color: "#544a83" }
            GradientStop { position: 1; color: "#e18b91" }
        }
    }
    Rectangle {
        width: parent.width * 1.2
        height: width
        radius: width / 2
        x: parent.width * 0.12
        y: parent.height * 0.27
        rotation: 24
        color: "#32ffffff"
    }
    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.16
        spacing: 5
        Text {
            text: Qt.formatTime(new Date(), "h:mm")
            color: "white"
            font.pixelSize: 68
            font.weight: Font.Light
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: Qt.formatDate(new Date(), "dddd, d MMMM")
            color: "#eff1ff"
            font.pixelSize: 17
            Layout.alignment: Qt.AlignHCenter
        }
    }
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: unlockButton.top
        anchors.bottomMargin: 24
        width: parent.width - 44
        height: 92
        radius: 22
        color: "#35ffffff"
        border.color: "#40ffffff"
        Column {
            anchors.centerIn: parent
            spacing: 7
            Text { text: "JanOS"; color: "white"; font.pixelSize: 17; font.bold: true }
            Text { text: "No tienes notificaciones nuevas"; color: "#edf0ff"; font.pixelSize: 12 }
        }
    }
    Button {
        id: unlockButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 54
        text: "Desbloquear JanOS"
        onClicked: lock.unlocked()
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        text: "Desliza o pulsa para continuar"
        color: "#eff1ff"
        font.pixelSize: 11
    }
}