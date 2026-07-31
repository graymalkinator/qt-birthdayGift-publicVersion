import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import theApp 1.0

Item {

    id: root

    property double prettyCount: Math.floor(Math.random() * 9000000000) + 1000000000
    property int dotCount: 0
    property double progress: 0
    property string text1
    property string text2
    property string progressEndColor
    property string progressEndText
    property int prettyOrBad

    signal progressDone

    Component.onCompleted: {
        prettyCount = Math.floor(Math.random() * 9000000000) + 1000000000
        switch(prettyOrBad) {
        case GlobalEnums.badPicturesContext:
            text1 = "Searching BAD pictures from " + root.prettyCount + " PRETTY pictures "
            text2 = "Still searching "
            progressEndColor = "#FF0000"
            progressEndText = "ERROR!"
            break;
        case GlobalEnums.prettyPicturesContext:
            text1 = "Picking THE PRETTIEST 5 pictures from " + root.prettyCount + " PRETTY pictures "
            text2 = "Arranging list "
            progressEndColor = "#BD36FF"
            progressEndText = "Finished."
            break;
        }
    }

    SequentialAnimation {
        running: true
        onStopped: root.progressDone()
        NumberAnimation {
            property: "progress"
            target: root
            from: 0
            to: 0.67
            duration: 3500
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: root
            property: "progress"
            from: 0.67
            to: 0.95
            duration: 3500
            easing.type: Easing.InOutQuad
        }

        PauseAnimation {
            duration: 500
        }

        NumberAnimation {
            target: root
            property: "progress"
            from: 0.95
            to: 1
            duration: 300
            easing.type: Easing.InOutQuad
        }

        PauseAnimation {
            duration: 200
        }
    }


    Timer {
        id: dotdotdotTimer

        interval: 500
        repeat: true
        running: root.progress < 1
        onTriggered: { root.dotCount = (root.dotCount+1) % 4
        }
    }

    ColumnLayout {
        spacing: 20
        anchors.centerIn: parent

        Text {
            Layout.preferredHeight: 35
            Layout.alignment: Qt.AlignHCenter
            text: root.prettyCount > 0 ?
                      root.progress < 0.7 ? text1  + ".".repeat(root.dotCount)
                                          : root.progress < 0.73 ?
                                                "" :
                                                text2 + ".".repeat(root.dotCount) : ""
            font.pixelSize: 22
            font.family: GlobalFonts.picsLoaderFont
            visible: root.progress < 1
            color: "white"
        }

        Text {
            Layout.preferredHeight: 35
            Layout.alignment: Qt.AlignHCenter
            text: root.progressEndText
            font.pixelSize: 30
            font.family: GlobalFonts.picsLoaderFont
            visible: root.progress === 1
            opacity: root.progress === 1 ? 1 : 0
            Behavior on opacity {NumberAnimation {duration: root.prettyOrBad === GlobalEnums.badPicturesContext ? 5 : 600 ? 5 : 600 } }
            color: root.progressEndColor
        }

        ProgressBar {
            id: progressbar

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 550
            from: 0
            to: 1
            value: root.progress

            background: Rectangle {
                implicitWidth: 300
                implicitHeight: 10
                color: "#e6e6e6"
                radius: height/3
            }
            contentItem: Rectangle {
                width: progressbar.visualPosition * progressbar.width
                height: parent.height
                color: progressbar.value < 1 ? "#2457FF" : root.progressEndColor
                radius: height/3

                Behavior on color { ColorAnimation {duration: root.prettyOrBad === GlobalEnums.badPicturesContext ? 5 : 600 ? 5 : 600 } }
            }
        }
    }
}
