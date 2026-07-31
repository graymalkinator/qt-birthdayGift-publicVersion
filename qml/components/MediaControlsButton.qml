import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import theApp 1.0

Button {
    id: root

    property string iconSource
    property color iconColor: "white"

    property bool useGradient: true
    property color startColor: "#00FFD1"
    property color endColor: "#007BFF"

    implicitWidth: 45
    implicitHeight: 45

    background: Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "#FFFFFF"
        opacity: root.down ? 0.2 : (root.hovered ? 0.1 : 0)
    }

    contentItem: Item {
        anchors.fill: parent

        Image {
            id: icon
            anchors.fill: parent
            source: GlobalEnums.assetsPath + "/mediaplayer/" + root.iconSource + ".png"
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        Rectangle {
            anchors.fill: parent
            visible: root.useGradient

            gradient: Gradient {
                GradientStop { position: 0.0; color: root.startColor }
                GradientStop { position: 1.0; color: root.endColor }
            }

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: icon
            }
        }

        ColorOverlay {
            anchors.fill: parent
            source: icon
            color: root.iconColor
            visible: !root.useGradient
        }
    }
}
