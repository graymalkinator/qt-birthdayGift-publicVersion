pragma Singleton
import QtQuick 2.15

QtObject {

    readonly property string landingScreen: "landingScreenComponent"
    readonly property string menuScreen: "menuScreenComponent"
    readonly property string picturesStuffScreen: "picturesStuffScreenComponent"
    readonly property string badPicturesScreen: "badPicturesScreenComponent"
    readonly property string prettyPicturesScreen: "prettyPicturesScreenComponent"
    readonly property string somethingElseFirstPage: "somethingElseComponent"
    readonly property string somethingElseEscapePage: "somethingElseEscapeComponent"
    readonly property string somethingElseFinalPage: "somethingElseFinalComponent"

    readonly property int badPicturesContext: 0
    readonly property int prettyPicturesContext: 1

    readonly property string fontPath: "qrc:/qt/qml/theApp/qml/fonts/"
    readonly property string assetsPath: "qrc:/qt/qml/theApp/qml/assets/"
    readonly property string songsPath: "qrc:/qt/qml/theApp/qml/songs/"
    readonly property string videoPath: "qrc:/qt/qml/theApp/qml/video/"
}
