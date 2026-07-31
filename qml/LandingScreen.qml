import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import theApp 1.0

Item {
    id: root

    objectName: "LandingScreen"
    property StackView stackView
    signal pushtostack(var page)

    PasscodePopup {
        id: passcodePopup

        onPushfromPopup:{
            root.pushtostack(GlobalEnums.menuScreen)
        }
    }

    Rectangle {
        id: mainRectangle
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0c1024" }
            GradientStop { position: 0.6; color: "#1b244a" }
            GradientStop { position: 1.0; color: "#2a1f3f" }
        }

        Image {
            id: butterflyButton

            anchors.centerIn: parent
            source: GlobalEnums.assetsPath + "butterflyButton.png"
            width: 60
            height: 60
            fillMode: Image.PreserveAspectFit

            scale: mouseArea.pressed ? 0.7 : mouseArea.containsMouse ? 1.1 : 1.0
            opacity:  mouseArea.containsMouse ? 0.9 : 1.0

            rotation: mouseArea.pressed ? 360 : mouseArea.containsMouse ? 10 : 0
            Behavior on scale {
                NumberAnimation { duration: 150 }
            }
            Behavior on opacity {
                NumberAnimation { duration: 150 }
            }
            Behavior on rotation {
                NumberAnimation { duration: 150 }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("Butterfly clicked")
                    passcodePopup.open()
                }
            }
        }
    }
}
