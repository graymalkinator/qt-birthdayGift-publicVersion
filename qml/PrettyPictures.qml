import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import theApp 1.0

import Qt.labs.folderlistmodel
import "UtilityStuff/prettypicturesDB.js" as PrettyPicturesDB

Item {
    id: root

    signal goBack

    property var selectedPhotos: []
    property int activeIndex: -1
    property var xMap: [0, -170, 170, -110, 110]
    property var yMap: [-100, -10, -10, 100, 100]

    function getBaseRotation(i) {
        let base = ((i % 2 === 0 ? -1 : 1) * (1 + i * 0.2))

        let random = (Math.random() - 0.5) * 1.4

        return base + random
    }

    PicturesStuffBg {
        anchors.fill: parent
    }

    FolderListModel {
        id: photoModel
        // folder: Qt.resolvedUrl(GlobalEnums.assetsPath + "pretty_pics")
        folder: ""
        Component.onCompleted: folder = GlobalEnums.assetsPath + "pretty_pics"
        nameFilters: ["*.jpg", "*.png"]
        showDirs: false
        onCountChanged: {
            console.log("Photos found:", count)
            selectedPhotos = PrettyPicturesDB.pickPretty(photoModel)
        }
    }

    Timer {
        id: delayTimer

        interval: 1300
        running: false


        onTriggered:  {
            picSearch.opacity = 0
            prettyContent.visible = true

        }
    }


    PicturesSearchProgressThing {
        id: picSearch

        anchors.centerIn: parent
        prettyOrBad: GlobalEnums.prettyPicturesContext

        Behavior on opacity {NumberAnimation {duration: 200 }}

        onProgressDone: {
            delayTimer.start()
        }
    }


    Item {
        id: prettyContent
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        visible: false

        Repeater {

            model: root.selectedPhotos
            delegate: PolaroidCard {
                id: card

                image: modelData.url
                caption: modelData.caption
                property real finalY: parent.height / 2 - height / 2 + root.yMap[index]
                property real baseRotation: root.getBaseRotation(index)

                rotation: baseRotation + 8
                Behavior on rotation {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.OutQuad
                    }
                }
                opacity: 0
                x: parent.width/2 - width/2 + root.xMap[index]
                y: finalY - 100
                z: isActive ? 100 : index

                Behavior on y {
                    NumberAnimation {
                        duration: 700
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on opacity {
                    NumberAnimation { duration: 350 }
                }
                isActive: index === root.activeIndex

                onCardClicked: {
                    root.activeIndex = index
                }

                Timer {
                    id: cardDropTimer
                    interval: 120 + index * 120
                    running: prettyContent.visible
                    repeat: false

                    onTriggered: {
                        card.y = card.finalY
                        card.opacity = 1
                         card.rotation = card.baseRotation
                    }
                }

                SequentialAnimation on rotation {
                    running: card.isActive
                    loops: Animation.Infinite

                    NumberAnimation {
                        to: baseRotation + 1.5
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }

                    NumberAnimation {
                        to: baseRotation - 1.5
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }


    }

}
