import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import theApp 1.0

Item {
    id: root

    objectName: "SomethingElseFirstPage"
    signal pushtostack(string pageName)
    signal goBack()

    Rectangle {
        id: mainRectangle
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1E2A38" }
            GradientStop { position: 1.0; color: "#261F30" }
        }

        Rectangle {
            id: questionRect

            anchors.centerIn: parent
            anchors.verticalCenterOffset: -30
            width: 440
            height: 225
            radius: 100

            rotation: Math.random() * 10 - 5
            color: questionMA.containsMouse ? "#55FFFFFF" : "#26FFFFFF"
            border.color: "#40FFFFFF"
            border.width: 2

            Text {
                anchors.bottom: mainText.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter

                text: "WARNING!!"
                color:  questionMA.containsMouse ? "#D9C900" : "#30D9C900"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 48
            }

            Text {
                id: mainText
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 25

                text: "This section contains questionable audio. . ."
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                color: questionMA.containsMouse ? "#E8ECF2" : "#50E8ECF2"
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

            SequentialAnimation on anchors.verticalCenterOffset {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    to: -20
                    duration: 2500
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    to: -40
                    duration: 2500
                    easing.type: Easing.InOutSine
                }
            }
        }

        Rectangle {
            id: yesBubble

            anchors.top: questionRect.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 75

            width: 100
            height: 100
            radius : 50

            scale: yesMA.pressed ? 0.9 : yesMA.containsMouse ? 1.1 : 1
            color: yesMA.containsMouse ? "#40FFFFFF" : "#35FFFFFF"
            border.color: "#8046D98A"
            border.width: 2

            Text {
                anchors.centerIn: parent
                wrapMode: Text.WordWrap

                text: "continue"
                color:  yesMA.containsMouse ? "#46D98A" : "#4046D98A"
                font.bold: true
                font.pixelSize: 22
                font.family: GlobalFonts.somethingElseFont
            }

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }


            MouseArea {
                id: yesMA

                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.pushtostack(GlobalEnums.somethingElseFinalPage)
                }
            }


            SequentialAnimation on anchors.topMargin {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    to: 45
                    duration: 1500
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    to: 20
                    duration: 1500
                    easing.type: Easing.InOutSine
                }
            }
        }

        Rectangle {
            id: noBubble

            anchors.top: questionRect.bottom
            anchors.topMargin: 45
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -75

            width: 90
            height: 90
            radius : 45

            border.color: "#80E06C75"
            border.width: 2


            scale: noMA.pressed ? 0.9 : noMA.containsMouse ? 1.1 : 1
            color: noMA.containsMouse ? "#40FFFFFF" : "#35FFFFFF"

            Behavior on scale {
                NumberAnimation { duration: 150 }
            }

            Text {
                anchors.centerIn: parent
                text: "escape"
                color:  noMA.containsMouse ? "#E06C75" : "#40E06C75"
                font.bold: true
                font.pixelSize: 22
                font.family: GlobalFonts.somethingElseFont
            }

            MouseArea {
                id: noMA

                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.pushtostack(GlobalEnums.somethingElseEscapePage)
                }
            }

            SequentialAnimation on anchors.topMargin {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    to: 30
                    duration: 1000
                    easing.type: Easing.InOutSine
                }

                NumberAnimation {
                    to: 50
                    duration: 1000
                    easing.type: Easing.InOutSine
                }
            }
        }
    }
}
