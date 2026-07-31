cmake_minimum_required(VERSION 3.16)

project(AnAppForM_____ VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(AnAppForM_____
    main.cpp
    appicon.rc
)
set_source_files_properties(
    qml/UtilityStuff/GlobalEnums.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(
    qml/UtilityStuff/GlobalFonts.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(AnAppForM_____
    URI theApp
    VERSION 1.0

    QML_FILES
    qml/Main.qml

    qml/LandingScreen.qml
    qml/MenuScreen.qml
    qml/PicturesStuffScreen.qml
    qml/BadPictures.qml
    qml/PrettyPictures.qml
    qml/MediaPlayerWidget.qml

    qml/SomethingElseFirstPage.qml
    qml/SomethingElseEscapePage.qml
    qml/SomethingElseFinalPage.qml

    qml/components/MenuButton.qml
    qml/components/PicturesSearchProgressThing.qml
    qml/components/PolaroidCard.qml
    qml/components/MusicButton.qml
    qml/components/MediaControlsButton.qml

    qml/popups/JustPopup.qml
    qml/popups/BadPicturesPopup.qml
    qml/popups/PasscodePopup.qml

    qml/UtilityStuff/GlobalEnums.qml
    qml/UtilityStuff/PicturesStuffBg.qml
    qml/UtilityStuff/GlobalFonts.qml

    RESOURCES

    qml/UtilityStuff/prettypicturesDB.js
    qml/UtilityStuff/SongsDB.js

    qml/fonts/Caveat.ttf
    qml/fonts/ProtestRiot.ttf
    qml/fonts/IntelOneMono-Italic.ttf
    qml/fonts/Schoolbell.ttf

    qml/assets/butterflyButton.png
    qml/assets/sunset.jpg
    qml/assets/music-icon.png
    qml/assets/empty-polaroid.png
    qml/assets/scribble.png

    #all the pretty pictures
    qml/assets/pretty_pics/cat-kitten_1.jpg
    qml/assets/pretty_pics/cat-kitten_2.jpg
    qml/assets/pretty_pics/cat-loafing.jpg
    qml/assets/pretty_pics/cat-meowing.jpg
    qml/assets/pretty_pics/cat-miscgroup_1.jpg
    qml/assets/pretty_pics/cat-miscgroup_2.jpg
    qml/assets/pretty_pics/cat-miscgroup_3.jpg
    qml/assets/pretty_pics/cat-orange_1.jpg
    qml/assets/pretty_pics/cat-orange_2.jpg
    qml/assets/pretty_pics/cat-random.jpg
    qml/assets/pretty_pics/cat-sleeping_1.jpg
    qml/assets/pretty_pics/cat-sleeping_2.jpg
    qml/assets/pretty_pics/cat-sleeping_3.jpg
    qml/assets/pretty_pics/cat-standing.jpg


    qml/assets/mediaplayer/prev.png
    qml/assets/mediaplayer/play.png
    qml/assets/mediaplayer/pause.png
    qml/assets/mediaplayer/next.png

    qml/assets/playbutton-video.png
    qml/assets/volume.png
    qml/assets/play.png
    qml/assets/pause.png

    qml/songs/Eyes_On_You.mp3
    qml/songs/I_Still_Hear_Your_Voice.mp3
    qml/songs/Say_You_Love_Me.mp3
    qml/songs/Waiting_For_You.mp3

    qml/video/cat-video.mp4

    qml/UtilityStuff/qmldir


)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(AnAppForM_____ PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apptheApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(AnAppForM_____
    PRIVATE
    Qt6::Quick
    Qt6::QuickControls2
)

include(GNUInstallDirs)
install(TARGETS AnAppForM_____
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
