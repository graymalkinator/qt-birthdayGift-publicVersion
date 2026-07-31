import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

JustPopup {
    width: 420
    height: 220

    showGlow: false

    bggradiant1: "#2A2F52"
    bggradiant2: "#1A2340"

    contentItem: ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 18

        Text {
            text: "Search Result"
            font.pixelSize: 26
            color: "#FF6B6B"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "No bad pictures found ❤️"
            font.pixelSize: 20
            color: "#F0E6DC"
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }
        Button {

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 160
            Layout.preferredHeight: 48

            background: Rectangle {
                color: "#BD36FF"
                radius: height / 2
            }

            contentItem: Text {
                text: "Close"
                font.pixelSize: 20
                font.bold: true
                color: "white"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
            }

            onClicked: close()
        }
    }
}
