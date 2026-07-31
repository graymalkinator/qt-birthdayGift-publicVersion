import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Popup {
    id: root

    focus: true
    closePolicy: Popup.CloseOnEscape
    // property bool showShadow
    property bool showShadow: true
    property bool showGlow: false

    property color glowColor: "#00FFD1"
    property color borderColor: "#55FFFFFF"

    property string bggradiant1: "#2A2F52"
    property string bggradiant2: "#1A2340"

    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 180
        }

        NumberAnimation {
            property: "scale"
            from: 0.9
            to: 1.02
            duration: 180
            easing.type: Easing.OutCubic
        }

        NumberAnimation {
            property: "scale"
            from: 1.02
            to: 1.0
            duration: 120
            easing.type: Easing.OutCubic
        }
    }

    width: 625
    height: 275

    anchors.centerIn: parent

    background: Item {
        Rectangle {
            id: glowRect

            anchors.fill: parent
            anchors.margins: -6

            radius: 26

            color: root.glowColor
            opacity: root.showGlow ? 0.12 : 0

            visible: root.showGlow
        }

        Rectangle {
            id: content

            anchors.fill: parent

            radius: 20

            border.width: 1
            border.color: root.borderColor

            gradient: Gradient {
                GradientStop { position: 0.0; color: root.bggradiant1 }
                GradientStop { position: 1.0; color: root.bggradiant2 }
            }

            layer.enabled: true
            layer.smooth: true
            layer.samples: 8

            layer.effect: MultiEffect {
                shadowEnabled: root.showShadow

                shadowColor: "#000000"
                shadowBlur: 1.0
                shadowVerticalOffset: 12

                opacity: 0.35
            }
        }
    }


}
