import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import theApp 1.0

Item {
    id: root

    property string image
    property string caption

    property bool isActive: false
    property bool isHovered: false

    signal cardClicked()

    width: 195
    height: 245
    scale: isActive ? 1.12 : (isHovered ? 1.05 : 1.0)
    Behavior on scale {NumberAnimation {duration: 250 }}

    // REAL soft shadow
    MultiEffect {
        anchors.fill: card
        source: card
        shadowEnabled: true
        shadowBlur: 0.6
        shadowVerticalOffset: 8
        shadowHorizontalOffset: 0
        shadowColor: "#55000000"
    }

    // Highlight / glow (conditional)
    MultiEffect {
        anchors.fill: card
        source: card

        visible: isHovered || isActive

        shadowEnabled: true
        shadowBlur: isActive ? 2 : isHovered ? 0.8 : 0.6
        shadowVerticalOffset: isActive ? 15 : 8
        shadowColor: isActive ? "#40FFD580" : isHovered ? "#20FFFFFF" : "#60FFFFFF"
    }

    MouseArea {
        id: cardMouseArea

        anchors.fill: card
        hoverEnabled: true

        onEntered: root.isHovered = true
        onExited: root.isHovered = false
        onClicked: {
            root.cardClicked()
        }
    }

    // card body
    Rectangle {
        id: card
        anchors.fill: parent
        radius: 10
        border.width: 1
        border.color: "#d8d3c8"

        // warm paper gradient
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#fdfcf8" }
            GradientStop { position: 1.0; color: "#eee9df" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            // PHOTO AREA
            Rectangle {
                id: prettypic

                // width: parent.width
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.7
                // height: parent.height * 0.7
                radius: 6
                clip: true
                color: "transparent"

                Image {
                    anchors.fill: parent
                    source: root.image
                    fillMode: Image.PreserveAspectFit
                }
            }

            // CAPTION
            Text {
                id: caption

                text: root.caption
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.pixelSize: 17
                font.family: GlobalFonts.prettyPicsFont
                color: "#5a5750"
                visible: root.isActive
                opacity: visible ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            Image {
                id: scribble

                Layout.fillWidth: true
                Layout.fillHeight: true
                source: GlobalEnums.assetsPath + "scribble.png"
                visible: !root.isActive
                opacity: visible ? 0.8 : 0
                Behavior on opacity {

                    NumberAnimation {
                        duration: 1200
                        easing.type: Easing.OutQuad
                    }
                }
            }

            // extra bottom blank (signature polaroid look)
            // Item {
            //     width: 1
            //     height: 20
            // }
        }
    }
}
