import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theApp 1.0

Item {
    id: root

    signal goBack

    PicturesStuffBg {
        anchors.fill: parent
    }

    Timer {
        id: delayTimer

        interval: 1400
        running: false


        onTriggered:  {
            picSearch.opacity = 0
            badpicturespopup.open()
        }

    }

    BadPicturesPopup {
        id: badpicturespopup

        onClosed: {
            root.goBack()
        }
    }

    PicturesSearchProgressThing {
        id: picSearch

        anchors.centerIn: parent
        prettyOrBad: GlobalEnums.badPicturesContext

        Behavior on opacity {NumberAnimation {duration: 200 }}

        onProgressDone: {
            delayTimer.start()
        }
    }

}
