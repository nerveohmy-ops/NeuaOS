import QtQuick
import NeuaShell
import "Components"
Window {
    id: root
    width: 960
    height: 600
    visible: true
    title: "NeuaOS Shell"
    color: NeuaTokens.background

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: NeuaTokens.background }
            GradientStop { position: 1.0; color: NeuaTokens.backgroundAlt }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: NeuaTokens.spacingXs

        Text {
            id: timeText
            anchors.horizontalCenter: parent.horizontalCenter
            color: NeuaTokens.textPrimary
            font.family: NeuaTokens.fontFamily
            font.pixelSize: NeuaTokens.fontClock
            font.weight: NeuaTokens.weightBold
            text: Qt.formatTime(new Date(), "hh:mm")
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: NeuaTokens.textSecondary
            font.family: NeuaTokens.fontFamily
            font.pixelSize: NeuaTokens.fontBody
            text: Qt.formatDate(new Date(), "dddd, d MMMM")
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeText.text = Qt.formatTime(new Date(), "hh:mm")
    }

    Island {
        anchors.top: parent.top
        anchors.topMargin: 10 // Жестко 10 пикселей вниз
        anchors.horizontalCenter: parent.horizontalCenter
    }
        // --- Dock (внизу по центру) ---
    Dock {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: NeuaTokens.spacingXl
        anchors.horizontalCenter: parent.horizontalCenter
    }
}