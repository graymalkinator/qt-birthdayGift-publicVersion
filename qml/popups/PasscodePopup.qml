import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

JustPopup {
    id: root

    property string generatedCode: ""
    property string otpInput: ""
    property bool wrongCode: false
    property real originalX: 0
    property bool unlocking: false


    property string fullCode: ""

    Timer {
        id: typeWriterTimer

        interval: 250
        repeat: true

        onTriggered: {
            if(generatedCode.length < fullCode.length) {
                generatedCode += fullCode[generatedCode.length]
            }
            else {
                stop()
            }
        }
    }

    Component.onCompleted: {
        originalX = otpRow.x
    }

    showGlow: true
    glowColor: "#FF5EE1"

    bggradiant1: "#32264F"
    bggradiant2: "#1B2342"

    borderColor: "#66FF5EE1"

    signal pushfromPopup
    signal passcodeCorrect

    onOpened: {
        hiddenInput.clear()
        root.generatedCode = ""
        root.otpInput = ""
        hiddenInput.forceActiveFocus()
    }

    anchors.centerIn: parent

    Timer {
        id: wrongTimer
        interval: 600
        onTriggered: wrongCode = false
    }

    Timer {
        id: unlockTimer
        interval: 550

        onTriggered: {
            root.close()
            root.pushfromPopup()
        }
    }

    SequentialAnimation {
        id: shakeAnimation

        NumberAnimation {
            target: otpRow
            property: "x"
            to: originalX - 10
            duration: 40
        }

        NumberAnimation {
            target: otpRow
            property: "x"
            to: originalX + 10
            duration: 40
        }

        NumberAnimation {
            target: otpRow
            property: "x"
            to: originalX - 6
            duration: 30
        }

        NumberAnimation {
            target: otpRow
            property: "x"
            to: originalX
            duration: 30
        }
    }
    contentItem: ColumnLayout {
        anchors.centerIn: parent
        anchors.topMargin: 20
        spacing: 6

        TextField {
            id: hiddenInput
            visible: false
            focus: true
            maximumLength: 6
            inputMethodHints: Qt.ImhDigitsOnly
            validator: RegularExpressionValidator {
                regularExpression: /^[0-9]{0,6}$/
            }
            onTextChanged: {
                root.otpInput = text
                if(root.otpInput.length === 6) {
                    if (root.otpInput === "0" + root.generatedCode) {
                        console.log("Unlocked!")
                        unlocking = true
                        unlockTimer.start()

                    } else {
                        console.log("Wrong code")

                        wrongCode = true
                        shakeAnimation.start()

                        wrongTimer.start()

                        hiddenInput.clear()

                    }
                }
            }
        }

        Rectangle {

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 60
            Layout.preferredWidth: 290

            border.width: 2
            border.color: "#00FFD1"
            opacity: 0.5
            radius: 50
            Text {

                anchors.centerIn: parent
                horizontalAlignment: Text.AlignHCenter

                text: "ENTER PASSCODE"
                color: "white"
                font.family: "Consolas"
                font.pixelSize: 28
                font.bold: true
            }
        }

        Row {
            id: otpRow
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            Repeater {
                model: 6

                Rectangle {
                    id: digitRects

                    width: 75
                    height: 75
                    radius: 16
                    border.width: 2
                    border.color: wrongCode
                                  ? "#FF6B6B"
                                  : index === otpInput.length
                                    ? "#FF5EE1"
                                    : "#777777"

                    color: otpInput.length > index || unlocking
                           ? "#1B2342"
                           : "#EBEBEB"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: hiddenInput.forceActiveFocus()
                    }

                    Text {
                        anchors.centerIn: parent
                        text: otpInput.length > index ? otpInput[index] : ""
                        color: otpInput.length > index ? "#FF5EE1" : "black"
                        font.pixelSize: 30
                        font.bold: true
                        opacity: unlocking ? 0 : 1

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 500
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            spacing: 30
            Layout.leftMargin: 30
            Button {
                id: generateButton

                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.preferredHeight: 25
                Layout.preferredWidth: 180
                text: "Generate passcode"
                font.pixelSize: 12
                font.bold: true
                font.letterSpacing: 2
                font.capitalization: Font.AllUppercase
                background: Rectangle {
                    color: "#346F9E"
                    radius: 30
                    opacity: 0.9
                }
                scale: pressed ? 0.95 : hovered ? 1.05 : 1
                onClicked: {
                    var num = Math.floor(Math.random() * 90000) + 10000
                    root.fullCode = num.toString()
                    root.generatedCode = ""

                    typeWriterTimer.start()
                    hiddenInput.forceActiveFocus()
                }
            }

            Rectangle {
                color: "transparent"
                visible: !!root.generatedCode
                Layout.preferredHeight: 30
                Layout.preferredWidth: 200
                radius: 8
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                border.color: "#00FFD1"
                border.width: root.generatedCode.length === 5 ? 1 : 0

                Behavior on border.width {
                    NumberAnimation { duration: 250 }}

                Text {
                    id: generatedCodeText
                    anchors.centerIn: parent
                    text: root.generatedCode.split("").join(" ")
                    horizontalAlignment: Text.AlignLeft
                    color: "#C7E5ED"
                    font.pixelSize: 26
                    font.letterSpacing: 3
                    font.bold: true
                    font.family: "Consolas"
                }
            }
        }


    }
}
