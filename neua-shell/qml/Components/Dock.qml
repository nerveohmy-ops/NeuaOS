import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import NeuaShell

Item {
    id: root
    width: parent.width - 80
    height: 64

    // Фон дока
    Rectangle {
        anchors.fill: parent
        radius: NeuaTokens.radiusPill
        color: NeuaTokens.surfaceTranslucent
        border.color: NeuaTokens.border
        border.width: 1

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, 0.3)
            shadowVerticalOffset: 10
            shadowBlur: 1.0
            blurEnabled: false
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: NeuaTokens.spacingLg
            anchors.rightMargin: NeuaTokens.spacingLg
            spacing: NeuaTokens.spacingXl

            // Левая группа (настройки, луна)
            RowLayout {
                spacing: NeuaTokens.spacingSm
                Layout.alignment: Qt.AlignVCenter
                
                // Настройки
                Item {
                    width: 40; height: 40
                    Canvas {
                        anchors.centerIn: parent
                        width: 18; height: 18
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = NeuaTokens.textPrimary;
                            for (var i = 0; i < 8; i++) {
                                var angle = i * Math.PI / 4;
                                ctx.rect(9 + Math.cos(angle)*7 - 1.5, 9 + Math.sin(angle)*7 - 1.5, 3, 3);
                            }
                            ctx.fill();
                            ctx.beginPath(); ctx.arc(9, 9, 5, 0, Math.PI*2);
                            ctx.fillStyle = NeuaTokens.surfaceTranslucent; ctx.fill();
                        }
                    }
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    scale: hovered ? 1.1 : 1.0
                    Behavior on scale { NumberAnimation { duration: 150 } }
                }
                
                // Луна
                Item {
                    width: 40; height: 40
                    Canvas {
                        anchors.centerIn: parent
                        width: 18; height: 18
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.fillStyle = NeuaTokens.textPrimary;
                            ctx.beginPath(); ctx.arc(9, 9, 7, 0, Math.PI*2); ctx.fill();
                            ctx.fillStyle = NeuaTokens.surfaceTranslucent;
                            ctx.beginPath(); ctx.arc(12, 6, 7, 0, Math.PI*2); ctx.fill();
                        }
                    }
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    scale: hovered ? 1.1 : 1.0
                    Behavior on scale { NumberAnimation { duration: 150 } }
                }
            }

            Item { Layout.fillWidth: true }

            // Центральная группа (приложения)
            RowLayout {
                spacing: NeuaTokens.spacingMd
                Layout.alignment: Qt.AlignVCenter
                
                Repeater {
                    model: 8
                    delegate: Item {
                        width: 40; height: 40
                        HoverHandler { id: hover; cursorShape: Qt.PointingHandCursor }
                        
                        // Фон при наведении
                        Rectangle {
                            anchors.fill: parent
                            radius: NeuaTokens.radiusPill
                            color: hover.hovered ? Qt.rgba(1,1,1,0.1) : "transparent"
                        }

                        Canvas {
                            anchors.centerIn: parent
                            width: 20; height: 20
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.fillStyle = NeuaTokens.textPrimary;
                                if (index === 0) { // Сетка
                                    for(var r=0; r<3; r++) for(var c=0; c<3; c++) { ctx.beginPath(); ctx.arc(3+c*7, 3+r*7, 2, 0, Math.PI*2); ctx.fill(); }
                                } else if (index === 1) { // Папка
                                    ctx.lineWidth = 1.5; ctx.strokeStyle = NeuaTokens.textPrimary;
                                    ctx.beginPath(); ctx.moveTo(3, 5); ctx.lineTo(8, 5); ctx.lineTo(10, 8); ctx.lineTo(17, 8); ctx.lineTo(17, 15); ctx.lineTo(3, 15); ctx.stroke();
                                } else if (index === 2) { // Лупа
                                    ctx.lineWidth = 1.5; ctx.strokeStyle = NeuaTokens.textPrimary;
                                    ctx.beginPath(); ctx.arc(8, 8, 5, 0, Math.PI*2); ctx.stroke();
                                    ctx.beginPath(); ctx.moveTo(12, 12); ctx.lineTo(17, 17); ctx.stroke();
                                } else if (index === 3) { // Музыка
                                    ctx.beginPath(); ctx.arc(6, 14, 3, 0, Math.PI*2); ctx.fill();
                                    ctx.fillRect(8, 4, 2, 10);
                                    ctx.fillRect(10, 4, 6, 2);
                                } else if (index === 4) { // Игры
                                    ctx.fillRect(3, 8, 14, 6);
                                } else if (index === 5) { // Самолет
                                    ctx.beginPath(); ctx.moveTo(3, 10); ctx.lineTo(17, 3); ctx.lineTo(13, 17); ctx.lineTo(9, 12); ctx.fill();
                                } else if (index === 6) { // Терминал
                                    ctx.lineWidth = 1.5; ctx.strokeStyle = NeuaTokens.textPrimary;
                                    ctx.strokeRect(3, 5, 14, 10);
                                    ctx.beginPath(); ctx.moveTo(6, 9); ctx.lineTo(8, 10); ctx.lineTo(6, 11); ctx.stroke();
                                } else { // Шестеренка (упрощенная)
                                    ctx.beginPath(); ctx.arc(10, 10, 6, 0, Math.PI*2); ctx.stroke();
                                }
                            }
                        }
                        scale: hover.hovered ? 1.2 : 1.0
                        Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }
                    }
                }
            }

            Item { Layout.fillWidth: true }

            // Правая группа (громкость, батарея)
            RowLayout {
                spacing: NeuaTokens.spacingSm
                Layout.alignment: Qt.AlignVCenter
                
                Rectangle {
                    width: 80; height: 32
                    radius: 16
                    color: Qt.rgba(1,1,1,0.1)
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 6
                        spacing: 4
                        
                        Canvas {
                            width: 12; height: 12
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.fillStyle = NeuaTokens.textPrimary;
                                ctx.beginPath(); ctx.moveTo(2, 5); ctx.lineTo(5, 5); ctx.lineTo(8, 2); ctx.lineTo(8, 10); ctx.lineTo(5, 7); ctx.lineTo(2, 7); ctx.fill();
                            }
                        }
                        
                        Rectangle {
                            Layout.fillWidth: true
                            height: 4; radius: 2
                            color: Qt.rgba(1,1,1,0.2)
                            Rectangle {
                                width: parent.width * 0.6; height: parent.height; radius: 2
                                color: NeuaTokens.textPrimary
                            }
                        }
                    }
                }
                
                Item {
                    width: 32; height: 32
                    Canvas {
                        anchors.centerIn: parent
                        width: 18; height: 10
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.strokeStyle = NeuaTokens.textPrimary; ctx.lineWidth = 1.5;
                            ctx.strokeRect(1, 1, 14, 8);
                            ctx.fillStyle = NeuaTokens.textPrimary; ctx.fillRect(15, 3, 2, 4);
                            ctx.fillRect(3, 3, 8, 4); // заряд
                        }
                    }
                }
            }
        }
    }
}