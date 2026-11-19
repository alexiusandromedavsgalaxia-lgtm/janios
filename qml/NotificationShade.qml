import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: shade
    property bool expanded: false
    signal closed()
    anchors.fill: parent
    color: "#b90b1020"

    MouseArea { anchors.fill: parent; onClicked: shade.closed() }

    Rectangle {
        width: parent.width - 24
        height: Math.min(parent.height * 0.72, 520)
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 12
        radius: 28
        color: "#f1f3f8"
        MouseArea { anchors.fill: parent; onClicked: {} }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 14
            RowLayout {
                Layout.fillWidth: true
                Text { text: "Notificaciones"; color: "#172033"; font.pixelSize: 23; font.bold: true }
                Item { Layout.fillWidth: true }
                Button { text: "Cerrar"; onClicked: shade.closed() }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 86
                radius: 17
                color: "white"
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 6
                    Text { text: "JanOS"; color: "#172033"; font.bold: true; font.pixelSize: 14 }
                    Text { text: "Tu nuevo espacio móvil está listo."; color: "#657087"; font.pixelSize: 12 }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 86
                radius: 17
                color: "white"
                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 6
                    Text { text: "Consejo"; color: "#172033"; font.bold: true; font.pixelSize: 14 }
                    Text { text: "Personaliza el fondo desde Ajustes."; color: "#657087"; font.pixelSize: 12 }
                }
            }
            Item { Layout.fillHeight: true }
            Button { Layout.fillWidth: true; text: "Borrar notificaciones"; onClicked: shade.closed() }
        }
    }
}