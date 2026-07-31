import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

import theApp 1.0

Item {
    id: root

    objectName: "SomethingElseFinalPage"
    signal goBack()

    function formatTime(ms)
    {
        let totalSeconds = Math.floor(ms / 1000)

        let minutes = Math.floor(totalSeconds / 60)
        let seconds = totalSeconds % 60

        return minutes + ":" + ("0" + seconds).slice(-2)
    }

    SequentialAnimation {
        id: startAnimation
        running: false

        NumberAnimation { target: playbutton; property: "opacity"; to: 0; duration: 500;}


        NumberAnimation { target: videoOutput; property: "opacity"; to: 1; duration: 500 }

    }

    Component.onCompleted: {
        console.log(mediaPlayer.source)
    }

    states: [
        State {
            name: "initial"
            when: playbutton.visible
            PropertyChanges {
                target: videoFrame
                width: 600
                height: 470
            }
            AnchorChanges {
                target: videoFrame
                anchors.verticalCenter: parent.verticalCenter
            }
            PropertyChanges {
                target: videoMouseArea
                enabled: false
            }
            PropertyChanges {
                target: videoControls
                visible: false
            }
        },
        State {
            name: "playing"
            when: !playbutton.visible
            PropertyChanges {
                target: videoFrame
                width: 552.5
                height: 310.25
                anchors.topMargin: 50
            }
            AnchorChanges {
                target: videoFrame
                anchors.top: parent.top
            }

            PropertyChanges {
                target: videoMouseArea
                enabled: true
            }
            PropertyChanges {
                target: videoControls
                visible: true
            }
        }
    ]

    Rectangle {
        id: mainRectangle
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1E2A38" }
            GradientStop { position: 1.0; color: "#261F30" }
        }

        Rectangle {
            anchors.centerIn: parent
            color: "#10000000"
            border.color: "#25FFFFFF"
            border.width: 3
            radius: 30
            width: 600
            height: 470
        }

        Rectangle {
            id: videoFrame

            anchors.horizontalCenter: parent.horizontalCenter
            radius: 24
            clip: true
            layer.enabled: true
            color: "#12000000"
            border.color: "#55FFFFFF"
            border.width: 3

            Behavior on width {
                NumberAnimation { duration: 1500; onRunningChanged: if(!running) mediaPlayer.play()}
            }

            MouseArea {
                id: videoMouseArea

                anchors.fill: parent
                onClicked: {
                    if(mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                        mediaPlayer.pause()
                    }
                    else
                        mediaPlayer.play()
                }
            }

            MediaPlayer {
                id: mediaPlayer

                source: GlobalEnums.videoPath +  "cat-video.mp4"
                videoOutput: videoOutput
                audioOutput: audioOutput
            }

            AudioOutput {
                id: audioOutput
                volume: 0.3
            }

            VideoOutput {
                id: videoOutput

                anchors.fill: parent
                opacity: 0

            }

            MenuButton {
                id: playbutton

                anchors.centerIn: parent

                width: 140
                height: 50

                visible: opacity > 0
                buttonRadius: 12
                buttonBgGradient: Gradient {
                    GradientStop { position: 0.0; color: "#E0E4EA" }
                    GradientStop { position: 0.5; color: "#C7CDD6" }
                    GradientStop { position: 1.0; color: "#AEB6C2" }
                }

                buttonIcon: "playbutton-video"
                buttonText: "Play"
                iconSize: 40
                buttonBorderWidth: 2
                buttonBorderColor: "#F5F7FA"
                wobbleOff: true

                Rectangle {
                    anchors.fill: parent
                    color: "white"
                    opacity: 0.35
                }

                onClicked: {
                    startAnimation.start()
                }

            }
        }
        Item {
            id: videoControls

            width: videoFrame.width
            height: 120
            visible: false
            opacity: visible ? 1 : 0
            anchors.top: videoFrame.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Behavior on opacity {
                NumberAnimation {duration: 200}
            }

            Slider {
                id: progressBar

                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                width: videoFrame.width * 0.9

                from: 0
                to: mediaPlayer.duration

                value: mediaPlayer.position

                onMoved: {
                    mediaPlayer.position = value
                }

                background: Rectangle {
                    x: progressBar.leftPadding
                    y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2

                    implicitWidth: 200
                    implicitHeight: 8

                    width: progressBar.availableWidth
                    height: 8
                    radius: 4

                    color: "#30FFFFFF"

                    Rectangle {
                        width: progressBar.visualPosition * parent.width
                        height: parent.height
                        radius: parent.radius

                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#B8C4D6" }
                            GradientStop { position: 1.0; color: "#8E9CB0" }
                        }
                    }
                }

                handle: Rectangle {
                    x: progressBar.leftPadding
                       + progressBar.visualPosition
                       * (progressBar.availableWidth - width)

                    y: progressBar.topPadding
                       + progressBar.availableHeight / 2
                       - height / 2

                    width: 12
                    height: 12

                    color: "#F5F7FA"
                    border.color: "#AEB6C2"
                }
            }

            Button {
                id: playpause

                property string iconname: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "pause" : "play"
                anchors.top: progressBar.bottom
                anchors.topMargin: 20
                anchors.left: progressBar.left
                anchors.rightMargin:  100
                width: 35
                height: 35

                contentItem: Image {
                    source: GlobalEnums.assetsPath + playpause.iconname + ".png"
                    fillMode: Image.PreserveAspectFit

                    scale: playpause.pressed ? 0.9 : playpause.hovered ? 1.1 : 1.0

                    Behavior on scale {
                        NumberAnimation { duration: 120 }
                    }
                }
                onClicked: {
                    if(mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                        mediaPlayer.pause()
                    }
                    else
                        mediaPlayer.play()
                }

                background: Item {}
            }

            Text {
                id: durationText

                anchors.left: playpause.right
                anchors.leftMargin: 100
                anchors.verticalCenter: playpause.verticalCenter

                color: "#E8ECF2"

                font.pixelSize: 18

                text: root.formatTime(mediaPlayer.position)
                      + " / "
                      + root.formatTime(mediaPlayer.duration)
            }
            Row {
                id: volumeLayout

                anchors.top: progressBar.bottom
                anchors.topMargin: 25
                anchors.right: progressBar.right

                spacing: 20

                Image {
                    width: 30
                    height: 30
                    fillMode: Image.PreserveAspectFit
                    source: GlobalEnums.assetsPath + "volume.png"
                }

                Slider {
                    id: volumeSlider

                    anchors.verticalCenter: parent.verticalCenter
                    width: 150
                    height: 16

                    from: 0
                    to: 1

                    value: audioOutput.volume
                    onValueChanged: {
                        audioOutput.volume = value
                    }

                    background: Rectangle {

                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding
                           + volumeSlider.availableHeight / 2
                           - height / 2

                        width: volumeSlider.availableWidth
                        height: 8
                        radius: 4
                        color: "#30FFFFFF"


                        Rectangle {
                            width: volumeSlider.visualPosition * parent.width
                            height: parent.height

                            radius: parent.radius

                            color: "#A9D0DB"
                        }
                    }

                    handle: Rectangle {
                        x: volumeSlider.leftPadding
                           + volumeSlider.visualPosition
                           * (volumeSlider.availableWidth - width)

                        y: volumeSlider.topPadding
                           + volumeSlider.availableHeight / 2
                           - height / 2

                        width: 20
                        height: 20
                        radius: 10

                        color: "#F5F7FA"
                        border.color: "#007BFF"
                        border.width: 2

                        scale: volumeSlider.pressed ? 1.45 : 1

                        Behavior on scale {
                            NumberAnimation {
                                duration: 120
                            }
                        }
                    }
                }
            }

        }
    }
}
