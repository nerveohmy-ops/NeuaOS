import QtQuick
import NeuaShell
import "Components"

Window {
    id: root
    width: 1200
    height: 800
    visible: true
    title: "NeuaOS Shell"
    color: NeuaTokens.background

    // Фон
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: NeuaTokens.background }
            GradientStop { position: 1.0; color: NeuaTokens.backgroundAlt }
        }
    }

    // Часы
    Column {
        anchors.centerIn: parent
        spacing: 8
        Text {
            id: timeText
            anchors.horizontalCenter: parent.horizontalCenter
            color: NeuaTokens.textPrimary
            font.family: NeuaTokens.fontFamily
            font.pixelSize: NeuaTokens.fontClock
            font.weight: NeuaTokens.weightBold
            text: Qt.formatTime(new Date(), "HH:mm")
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: NeuaTokens.textSecondary
            font.family: NeuaTokens.fontFamily
            font.pixelSize: 14
            font.letterSpacing: 2.0
            text: Qt.formatDate(new Date(), "dddd, d MMMM").toUpperCase()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeText.text = Qt.formatTime(new Date(), "HH:mm")
    }

    // Island (сверху)
    Island {
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // Виджеты (справа)
    Widgets {
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -20 // Чуть выше центра
    }

    // Док (снизу)
    Dock {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        anchors.horizontalCenter: parent.horizontalCenter
    }
}