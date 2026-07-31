import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theApp 1.0

Item {
    id: root

    signal pushtostack(string pageName)

    SequentialAnimation {
        id: introAnim
        running: true

        ParallelAnimation {
            NumberAnimation { target: button_music; property: "opacity"; to: 1; duration: 250 }
            NumberAnimation { target: button_music; property: "scale"; to: 1; duration: 250 }
        }

        PauseAnimation { duration: 80 }

        ParallelAnimation {
            NumberAnimation { target: button_pictures; property: "opacity"; to: 1; duration: 250 }
            NumberAnimation { target: button_pictures; property: "scale"; to: 1; duration: 250 }
        }

        PauseAnimation { duration: 80 }

        ParallelAnimation {
            NumberAnimation { target: button_stuff; property: "opacity"; to: 1; duration: 250 }
             NumberAnimation { target: button_stuff; property: "scale"; to: 1; duration: 250 }
        }
    }

    Image {
        anchors.fill: parent
        source: GlobalEnums.assetsPath + "sunset.jpg"
        asynchronous: true
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.35

        Text {
            anchors {
                left: parent.left
                leftMargin: 15
                bottom: parent.bottom
                bottomMargin: 10
            }
            text: "Photo shot by M_____"
            color: "white"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                button_music.isOpen = false
            }
        }

        ColumnLayout {
            anchors {
                right: parent.right
                rightMargin: 15
                top: parent.top
                topMargin: 50
            }

            spacing: 12

            MusicButton {
                id: button_music
                Layout.preferredHeight: isOpen ? 100 : 75
                Layout.preferredWidth: 360
                Layout.alignment: Qt.AlignHCenter

                opacity: 0
                buttonIcon: "music-icon.png"
                buttonText: "Play some M_____ songs!"
            }

            MenuButton {
                id: button_pictures
                Layout.preferredHeight: 75
                Layout.preferredWidth: 360
                Layout.alignment: Qt.AlignHCenter

                opacity: 0
                buttonIcon: "empty-polaroid.png"
                buttonText: "See some M_____ Pix!"

                onClicked:{
                    button_music.isOpen = false
                    root.pushtostack(GlobalEnums.picturesStuffScreen)
                }

            }

            MenuButton {
                id: button_stuff
                Layout.preferredHeight: 75
                Layout.preferredWidth: 360
                Layout.alignment: Qt.AlignHCenter

                opacity: 0
                buttonText: "Play something else 👀"

                onClicked: {
                    button_music.isOpen = false
                    root.pushtostack(GlobalEnums.somethingElseFirstPage)
                }
            }
        }
    }
}
