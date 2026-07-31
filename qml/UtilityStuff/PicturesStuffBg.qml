import QtQuick 2.15

Rectangle {
    anchors.fill: parent
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#2b1f2f" }   // deep purple
        GradientStop { position: 0.5; color: "#3b2a3a" }
        GradientStop { position: 1.0; color: "#1c1c2a" }   // dark navy
    }
}
