import QtQuick
import QtQuick.Controls
import theApp 1.0

ApplicationWindow {
    id: root

    width: 980
    height: 540
    minimumWidth: 980
    minimumHeight: 540
    maximumWidth: 980
    maximumHeight: 540
    visible: true
    title: "This is for M_____!"

    Component.onCompleted:  {
        console.log("Preload fonts", GlobalFonts.prettyPicsFont, GlobalFonts.songNameFont, GlobalFonts.picsLoaderFont, GlobalFonts.somethingElseFont)
    }

    header: Button {
        id: backbutton

        height: 40
        width: 100
        text: "<<"
        font.pixelSize: 20
        visible: stack.depth > 1
        onClicked: stack.pop()

        background: Rectangle {
            border.width: 1
            border.color: "white"
            color: "transparent"
        }
    }

    property var pageMap: ({
                               [GlobalEnums.landingScreen]: landingScreenComponent,
                               [GlobalEnums.menuScreen]: menuScreenComponent,
                               [GlobalEnums.picturesStuffScreen]: picturesStuffScreenComponent,
                               [GlobalEnums.badPicturesScreen]: badPicturesScreenComponent,
                               [GlobalEnums.prettyPicturesScreen]: prettyPicturesScreenComponent,
                               [GlobalEnums.somethingElseFirstPage]: somethingElseComponent,
                               [GlobalEnums.somethingElseEscapePage]: somethingElseEscapeComponent,
                               [GlobalEnums.somethingElseFinalPage]: somethingElseFinalComponent
                           })

    function pushtostack(page) {
        console.log("What's pushed : ", page)
        var component = root.pageMap[page]
        if(component) {
            stack.push(component);
        }
    }

    StackView {
        id: stack

        anchors.fill: parent

        initialItem: LandingScreen {
            stackView: stack

            onPushtostack: function(pageName) {
                root.pushtostack(pageName)
            }
        }


        pushEnter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "y"
                    from: 40
                    to: 0
                    duration: 250
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 220
                }
            }
        }

        pushExit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 180
            }
        }

        popEnter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 180
            }
        }

        popExit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "y"
                    from: 0
                    to: 40
                    duration: 200
                    easing.type: Easing.InCubic
                }
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 180
                }
            }
        }
    }


    Component {
        id: landingScreenComponent
        LandingScreen {
            onPushtostack: function(page) {
                root.pushtostack(page)
            }
        }
    }
    Component {
        id: menuScreenComponent
        MenuScreen {
            onPushtostack: function(page) {
                root.pushtostack(page)
            }
        }
    }

    Component {
        id: picturesStuffScreenComponent

        PicturesStuffScreen {
            onPushtostack: function(page) {
                root.pushtostack(page)
            }
        }
    }

    Component {
        id: badPicturesScreenComponent
        BadPictures {
            onGoBack: backbutton.clicked()
        }
    }

    Component {
        id: prettyPicturesScreenComponent
        PrettyPictures {
            onGoBack: backbutton.clicked()
        }
    }

    Component {
        id: somethingElseComponent
        SomethingElseFirstPage {
            onGoBack: backbutton.clicked()

            onPushtostack: function(page) {
                root.pushtostack(page)
            }
        }
    }

    Component {
        id: somethingElseEscapeComponent
        SomethingElseEscapePage {
            onGoBack: backbutton.clicked()
        }
    }

    Component {
        id: somethingElseFinalComponent
        SomethingElseFinalPage {
             onGoBack: backbutton.clicked()
        }
    }
}
