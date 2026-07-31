import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Button {
    id: root
    property int buttonRadius: 25
    property string buttonText: ""
    property string buttonIcon: ""
    property string buttonTextColor: "#F6C8A8"
    property string buttonBorderColor: "#F6C8A8"
    property int buttonBorderWidth: 1
    property int iconSize: 45
    property bool wobbleOff: false
    property Gradient buttonBgGradient: Gradient {
        GradientStop { position: 0.0; color: "#3A2722" }
        GradientStop { position: 1.0; color: "#241915" }
    }
    scale: down ? 0.9 : hovered ? 1.05 : 1
    Behavior on scale { NumberAnimation { duration: 500 } }

    contentItem: RowLayout {
        // spacing: 5
        anchors.centerIn: parent
        // anchors.leftMargin: 7

        Item {
            Layout.fillWidth: true
        }

        Image {
            id: iconImage
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            source: root.buttonIcon ? GlobalEnums.assetsPath + root.buttonIcon : ""
            visible: !!buttonIcon
            Layout.preferredHeight: root.iconSize
            Layout.preferredWidth: root.iconSize
            fillMode: Image.PreserveAspectFit
        }

        Text {
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
            text: root.buttonText
            color: root.buttonTextColor
            font.bold: true
            font.pixelSize: 20
            font.letterSpacing: 2
            font.family: "Comic Sans MS"
        }
        Item {
            Layout.fillWidth: true
        }

    }

    background: Rectangle {
        radius: root.buttonRadius
        opacity: opacity = root.down ? 0.3 : root.hovered ? 0.8 : 0.65

        gradient: root.buttonBgGradient

        border.color: root.buttonBorderColor
        border.width: root.buttonBorderWidth
    }

    hoverEnabled: true

    onHoveredChanged: {
        background.opacity = hovered ? 0.8 : 0.65
        root.scale = hovered ? 1.025 : 1
    }

    SequentialAnimation {
        id: wobble
        running: root.wobbleOff ? false : hovered ? true : false
        loops: Animation.Infinite

        NumberAnimation { target: iconImage; property: "rotation"; to: 5; duration: 300 }
        NumberAnimation { target: iconImage; property: "rotation"; to: -5; duration: 300 }
        NumberAnimation { target: iconImage; property: "rotation"; to: 5; duration: 300 }
        NumberAnimation { target: iconImage; property: "rotation"; to: -5; duration: 300 }
    }
}
