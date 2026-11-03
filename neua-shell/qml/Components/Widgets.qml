import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import NeuaShell

Item {
    width: 300
    height: 300

    // Сетка для точного позиционирования
    Grid {
        anchors.fill: parent
        columns: 2
        spacing: 16

        // --- 1. Кнопка WISHES ---
        Rectangle {
            width: 130
            height: 56
            radius: 28
            color: NeuaTokens.surfaceTranslucent
            border.color: NeuaTokens.border
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 8

                // Красный круг с паузой
                Rectangle {
                    width: 48; height: 48
                    radius: 24
                    color: NeuaTokens.accent
                    
                    Canvas {
                        anchors.centerIn: parent
                        width: 12; height: 12
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = "#FFFFFF";
                            ctx.fillRect(1, 1, 3, 10);
                            ctx.fillRect(8, 1, 3, 10);
                        }
                    }
                }

                Text {
                    text: "WISHES"
                    color: NeuaTokens.textPrimary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 10
                    font.weight: NeuaTokens.weightBold
                    font.letterSpacing: 1.0
                }
                Item { Layout.fillWidth: true }
            }
        }

        // --- 2. Календарь (Круг) ---
        Rectangle {
            width: 130; height: 130
            radius: 65
            color: NeuaTokens.surfaceTranslucent
            border.color: NeuaTokens.border
            border.width: 1

            Column {
                anchors.centerIn: parent
                spacing: 0
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Qt.formatDate(new Date(), "dddd").toUpperCase()
                    color: NeuaTokens.textPrimary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 9
                    font.weight: NeuaTokens.weightBold
                    font.letterSpacing: 1.2
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Qt.formatDate(new Date(), "dd")
                    color: NeuaTokens.textPrimary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 48
                    font.weight: NeuaTokens.weightBold
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Qt.formatDate(new Date(), "MMMM").toUpperCase()
                    color: NeuaTokens.accent
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 9
                    font.weight: NeuaTokens.weightBold
                    font.letterSpacing: 1.2
                }
            }
        }

        // --- 3. Погода ---
        Rectangle {
            width: 130; height: 130
            radius: 24
            color: NeuaTokens.surfaceTranslucent
            border.color: NeuaTokens.border
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 0

                RowLayout {
                    Layout.fillWidth: true
                    Text {
                        text: "12°"
                        color: NeuaTokens.textPrimary
                        font.family: NeuaTokens.fontFamily
                        font.pixelSize: 28
                        font.weight: NeuaTokens.weightBold
                    }
                    Item { Layout.fillWidth: true }
                    Canvas {
                        width: 20; height: 14
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = NeuaTokens.textPrimary;
                            ctx.beginPath();
                            ctx.arc(6, 8, 4, Math.PI, Math.PI*2);
                            ctx.arc(12, 5, 6, Math.PI, Math.PI*2);
                            ctx.arc(17, 8, 3, Math.PI, Math.PI*2);
                            ctx.fill();
                            ctx.fillRect(6, 8, 11, 4);
                        }
                    }
                }
                Item { Layout.fillHeight: true }
                Text {
                    text: "Berlin"
                    color: NeuaTokens.textPrimary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 12
                }
                Text {
                    text: "Mostly Cloudy"
                    color: NeuaTokens.textSecondary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 10
                }
            }
        }

        // --- 4. Батарея (Правильная пилюля) ---
        Rectangle {
            width: 130; height: 56
            radius: 28
            color: NeuaTokens.surfaceTranslucent
            border.color: NeuaTokens.border
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 0

                // Левая красная часть
                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 16
                    radius: 20
                    color: NeuaTokens.accent
                    Canvas {
                        anchors.centerIn: parent
                        width: 8; height: 6
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = "#FFFFFF";
                            ctx.fillRect(0, 0, 8, 6);
                        }
                    }
                }

                // Центральный белый круг
                Rectangle {
                    width: 44; height: 44
                    radius: 22
                    color: NeuaTokens.textPrimary
                    Text {
                        anchors.centerIn: parent
                        text: "78%"
                        color: NeuaTokens.background
                        font.family: NeuaTokens.fontFamily
                        font.pixelSize: 11
                        font.weight: NeuaTokens.weightBold
                    }
                }

                // Правая красная часть
                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    radius: 20
                    color: NeuaTokens.accent
                }
            }
        }
    }
}