import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import theApp 1.0

Item {
    id: root

    objectName: "SomethingElseEscapePage"
    signal goBack()

    Rectangle {
        id: mainRectangle
        anchors.fill: parent

        rotation: -1.5

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1E2A38" }
            GradientStop { position: 1.0; color: "#261F30" }
        }

        Rectangle {
            id: questionRect

            anchors.centerIn: parent
            anchors.verticalCenterOffset: -45
            width: 350
            height: 110
            radius: 55

            scale: questionMA.containsMouse ? 1.05 : 1
            color: "#10FFFFFF"
            border.color: "#30FFFFFF"
            border.width: 2

            Text {
                anchors.centerIn: parent

                text: "Aww, Really ? :("
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: "#50E8ECF2"
                font.pixelSize: 44
                font.family: GlobalFonts.somethingElseFont
            }

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: -8
                radius: parent.radius + 8
                color: "#15FFFFFF"
                z: -1
            }

            MouseArea {
                id: questionMA

                anchors.fill: parent
                hoverEnabled: true

            }

            SequentialAnimation on y {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    to: -5
                    duration: 2500
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    to: 5
                    duration: 2500
                    easing.type: Easing.InOutSine
                }
            }

            SequentialAnimation on rotation {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    to: -2.5
                    duration: 1600
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    to: -0.5
                    duration: 1600
                    easing.type: Easing.InOutSine
                }
            }
        }

        Rectangle {
            id: gobackBubble

            anchors.top: questionRect.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            width: 175
            height: 70
            radius : 35

            scale: gobackMA.pressed ? 0.9 : gobackMA.containsMouse ? 1.1 : 1
            color: gobackMA.containsMouse ? "#40FFFFFF" : "#35FFFFFF"
            border.color:  gobackMA.containsMouse ? "#25AFD9" : "#8025AFD9"
            border.width: 2

            Text {
                anchors.centerIn: parent
                wrapMode: Text.WordWrap

                text: "Fine, I'll listen. . ."
                color: gobackMA.containsMouse ? "#25AFD9" : "#4025AFD9"
                font.bold: true
                font.pixelSize: 22
                font.family: GlobalFonts.somethingElseFont
            }

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }


            MouseArea {
                id: gobackMA

                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.goBack()
                }
            }


            SequentialAnimation on anchors.topMargin {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    to: 35
                    duration: 2200
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    to: 20
                    duration: 2200
                    easing.type: Easing.InOutSine
                }
            }
        }

    }
}
