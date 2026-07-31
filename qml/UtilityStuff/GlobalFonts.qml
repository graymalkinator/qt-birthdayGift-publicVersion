pragma Singleton
import QtQuick
import theApp 1.0

Item {
    FontLoader {
        id: prettyPicsFontLoader
        source: GlobalEnums.fontPath + "Caveat.ttf"
    }

    FontLoader {
        id: songNameFontLoader
        source: GlobalEnums.fontPath + "ProtestRiot.ttf"
    }

    FontLoader {
        id: picsLoaderFontLoader
        source: GlobalEnums.fontPath + "IntelOneMono-Italic.ttf"
    }

    FontLoader {
        id: somethingElseFontLoader
        source: GlobalEnums.fontPath + "Schoolbell.ttf"
    }

    property string prettyPicsFont: prettyPicsFontLoader.name
    property string songNameFont: songNameFontLoader.name
    property string picsLoaderFont: picsLoaderFontLoader.name
    property string somethingElseFont: somethingElseFontLoader.name
}
