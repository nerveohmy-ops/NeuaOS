import QtQuick
import QtQuick.Effects
import NeuaShell
import QtQuick.Layouts

Item {
    id: root
    width: 360
    height: 44

    Rectangle {
        anchors.fill: parent
        radius: 22
        color: NeuaTokens.surfaceTranslucent
        border.color: NeuaTokens.border
        border.width: 1

        RowLayout {
            anchors.fill: parent
            anchors.margins: 6
            spacing: 12

            // Красная точка
            Rectangle {
                width: 6; height: 6; radius: 3
                color: NeuaTokens.accent
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 6
            }

            // Обложка
            Rectangle {
                width: 32; height: 32; radius: 4
                color: Qt.rgba(1,1,1,0.1)
                Layout.alignment: Qt.AlignVCenter
                // Просто крестик для имитации обложки
                Canvas {
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.strokeStyle = Qt.rgba(1,1,1,0.3); ctx.lineWidth = 1;
                        ctx.beginPath(); ctx.moveTo(4,4); ctx.lineTo(28,28); ctx.moveTo(28,4); ctx.lineTo(4,28); ctx.stroke();
                    }
                }
            }

            // Текст
            Column {
                Layout.alignment: Qt.AlignVCenter
                Text {
                    text: "Nothing Left"
                    color: NeuaTokens.textPrimary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 13
                    font.weight: NeuaTokens.weightBold
                }
                Text {
                    text: "The Neighbourhood"
                    color: NeuaTokens.textSecondary
                    font.family: NeuaTokens.fontFamily
                    font.pixelSize: 11
                }
            }

            Item { Layout.fillWidth: true }

            // Кнопки управления (идеальные треугольники и паузы)
            RowLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 12
                Layout.rightMargin: 6
                
                Canvas {
                    width: 12; height: 12
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.fillStyle = NeuaTokens.textPrimary;
                        ctx.beginPath(); ctx.moveTo(10, 1); ctx.lineTo(1, 6); ctx.lineTo(10, 11); ctx.fill();
                    }
                }
                Canvas {
                    width: 12; height: 12
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.fillStyle = NeuaTokens.textPrimary;
                        ctx.fillRect(1, 1, 3, 10); ctx.fillRect(8, 1, 3, 10);
                    }
                }
                Canvas {
                    width: 12; height: 12
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.fillStyle = NeuaTokens.textPrimary;
                        ctx.beginPath(); ctx.moveTo(2, 1); ctx.lineTo(11, 6); ctx.lineTo(2, 11); ctx.fill();
                    }
                }
            }
        }
    }
}