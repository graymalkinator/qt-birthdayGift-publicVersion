import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theApp 1.0

Item {
    id: root
    property bool isOpen: false

    property alias buttonText: playMusic.buttonText
    property alias buttonIcon: playMusic.buttonIcon
    property alias buttonTextColor: playMusic.buttonTextColor

    implicitWidth: 375
    implicitHeight: 75

    signal clicked()

    MenuButton {
        id: playMusic
        anchors.fill: parent

        opacity: root.isOpen ? 0 : 1

        onClicked: {
            console.error("music clicked!")
            root.clicked()
            root.isOpen = true
        }

        Behavior on opacity { NumberAnimation { duration: 500 } }
        Behavior on scale { NumberAnimation { duration: 500 } }
    }

    MediaPlayerWidget {
        id: mediaplayer

        width: 345
        height: 100
        anchors.centerIn: parent

        enabled: root.isOpen
        opacity: root.isOpen ? 1 : 0
        scale: root.isOpen ? 1 : 0.98

        Behavior on opacity { NumberAnimation { duration: 500 } }
        Behavior on scale { NumberAnimation { duration: 500 } }
    }
}
