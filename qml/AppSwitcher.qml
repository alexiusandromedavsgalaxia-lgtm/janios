import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: switcher
    anchors.fill: parent
    color: "#d90b1020"
    signal dismissed()
    signal appSelected(string appName)

    MouseArea { anchors.fill: parent; onClicked: switcher.dismissed() }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 22
        spacing: 18

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: "Aplicaciones recientes"
                color: "white"
                font.pixelSize: 23
                font.bold: true
            }
            Item { Layout.fillWidth: true }
            Button { text: "Cerrar"; onClicked: switcher.dismissed() }
        }

        Repeater {
            model: [
                ["Mensajes", "Conversaciones recientes", "#3289ed", "✉"],
                ["Fotos", "Tus recuerdos", "#e6a24a", "▧"],
                ["Navegador", "Una nueva ventana", "#3c9ce8", "◎"]
            ]
            delegate: Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 142
                radius: 22
                color: "#f4f6fb"
                border.color: "#55ffffff"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    RowLayout {
                        Rectangle {
                            width: 38; height: 38; radius: 12
                            color: modelData[2]
                            Text { anchors.centerIn: parent; text: modelData[3]; color: "white"; font.pixelSize: 21 }
                        }
                        Text { text: modelData[0]; color: "#172033"; font.pixelSize: 16; font.bold: true }
                        Item { Layout.fillWidth: true }
                        Button {
                            text: "Abrir"
                            onClicked: switcher.appSelected(modelData[0])
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 13
                        color: "#e7ebf3"
                        Text {
                            anchors.centerIn: parent
                            text: modelData[1]
                            color: "#657087"
                            font.pixelSize: 13
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: switcher.appSelected(modelData[0])
                }
            }
        }

        Item { Layout.fillHeight: true }
        Button {
            Layout.fillWidth: true
            text: "Volver a la pantalla de inicio"
            onClicked: switcher.dismissed()
        }
    }
}