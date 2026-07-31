import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import theApp 1.0

Item {
    id: root

    signal pushtostack(string pageName)

    ParallelAnimation {
        id: introAnim
        running: true

        NumberAnimation { target: prettyPictures; property: "opacity"; to: 1; duration: 400 }
        NumberAnimation { target: prettyPictures; property: "scale"; to: 1; duration: 400 }
        NumberAnimation { target: badPictures; property: "opacity"; to: 1; duration: 400 }
        NumberAnimation { target: badPictures; property: "scale"; to: 1; duration: 400 }
    }

    PicturesStuffBg {
        anchors.fill: parent
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: parent.width * 0.1

        MenuButton {
            id: prettyPictures

            buttonRadius: 90
            opacity: 0
            scale: 0.8
            Layout.preferredHeight: 180
            Layout.preferredWidth: 180


            buttonText: "Pretty \nPictures"
            buttonTextColor: "#F3E8FF"

            buttonBgGradient: Gradient {
                GradientStop { position: 0.0; color: "#4a2c4f" }   // purple-brown
                GradientStop { position: 1.0; color: "#2a1b2e" }
            }

            layer.enabled: prettyPictures.hovered
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor:"#BD36FF"
                shadowBlur: 0.9
                shadowOpacity: 0.7
            }

            onClicked: {
                root.pushtostack(GlobalEnums.prettyPicturesScreen)
            }
        }
        MenuButton {
            id: badPictures

            buttonRadius: 90
            opacity: 0
            scale: 0.8
            Layout.preferredHeight: 180
            Layout.preferredWidth: 180

            buttonText: "BAD \nPictures"
            buttonTextColor: "#FFE5E5"

            buttonBgGradient: Gradient {
                GradientStop { position: 0.0; color: "#3A2222" }   // reddish brown
                GradientStop { position: 1.0; color: "#251515" }
            }

            layer.enabled: badPictures.hovered
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor:"#FF6B6B"
                shadowBlur: 0.9
                shadowOpacity: 0.7
            }

            onClicked: {
                root.pushtostack(GlobalEnums.badPicturesScreen)
            }
        }
    }
}
