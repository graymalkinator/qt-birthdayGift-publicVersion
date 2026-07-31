import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theApp 1.0
import QtMultimedia
import Qt.labs.folderlistmodel
import "UtilityStuff/SongsDB.js" as SongsDB

Rectangle {
    id: root

    width: 375
    height: 100

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#4A322B" }   // slightly lighter top
        GradientStop { position: 1.0; color: "#1E1411" }   // slightly darker bottom
    }
    opacity: 0.9
    radius: 25
    border.color: "#5A3A32"
    border.width: 1

    property string songNameText: "Click play 🦋"

    function playSong(index)
    {
        if (index < 0 || index >= songsModel.count)
            return

        var fileName = songsModel.get(index, "fileName")
        var fileBaseName = songsModel.get(index, "fileBaseName")
        var source = songsModel.folder + fileName

        mediaplayerLoader.item.source = source
        root.songNameText =  SongsDB.prettify(fileBaseName)
        mediaplayerLoader.item.play()
    }

    FolderListModel {
        id: songsModel
        folder: ""
        Component.onCompleted: folder =GlobalEnums.songsPath
        nameFilters: ["*.mp3"]
        showDirs: false
        onCountChanged: {
            if (count > 0)
                SongsDB.initialize(count)
            // songsList = SongSelector.songRandomizer(songsModel)
        }
    }

    Slider {
        id: volumeSlider

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 5

        orientation: Qt.Vertical

        height: 70
        width: 30

        from: 0
        to: 1
        value: 0.3

        handle: Rectangle {
            width: 18
            height: 18
            radius: 9

            color: "#FF5EE1"
            border.color: "#007BFF"
            border.width: 2

            x: volumeSlider.leftPadding
               + volumeSlider.availableWidth / 2
               - width / 2

            y: volumeSlider.visualPosition
               * (volumeSlider.availableHeight - height)

            scale: volumeSlider.pressed ? 1.15 : 1.0

            Behavior on scale {
                NumberAnimation {
                    duration: 120
                }
            }
        }
    }

    Loader {
        id: mediaplayerLoader

        active: root.visible
        sourceComponent: MediaPlayer {
            audioOutput: AudioOutput {
                volume: volumeSlider.value}
        }
    }

    ColumnLayout {
        id: mainLayout
        anchors.centerIn: parent
        spacing: 10

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 280
            Layout.preferredHeight: 34

            radius: 17

            color: "#2A1D19"
            border.width: 1
            border.color: "#00FFD155"

            opacity: 0.95

            Text {
                id: songName

                anchors.centerIn: parent

                text: root.songNameText
                color: "#CFFFF6"
                font.pixelSize: 22
                font.family: GlobalFonts.songNameFont
            }
        }

        RowLayout {
            id: buttonLayout
            Layout.alignment: Qt.AlignHCenter
            spacing: 45

            MediaControlsButton {
                id: prev
                iconSource: "prev"
                onClicked: {
                    playSong(SongsDB.previousSong())
                }
            }
            MediaControlsButton {
                id: playpause
                iconSource: mediaplayerLoader.item.playbackState === MediaPlayer.PlayingState
                            ? "pause" : "play"
                onClicked: {

                    if (!mediaplayerLoader.item)
                        return

                    if (mediaplayerLoader.item.playbackState
                            === MediaPlayer.PlayingState)
                    {
                        mediaplayerLoader.item.pause()
                    }
                    else {

                        // no song yet
                        if (SongsDB.currentSong() === -1)
                            playSong(SongsDB.nextSong())
                        else
                            mediaplayerLoader.item.play()
                    }
                }
            }
            MediaControlsButton {
                id: next
                iconSource: "next"
                onClicked: {
                    playSong(SongsDB.nextSong())
                }
            }
        }
    }


}
