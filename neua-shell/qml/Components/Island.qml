import QtQuick
import QtQuick.Effects
import NeuaShell

Item {
    id: root
    width: 380
    height: 48

    // Добавляем обработчик наведения мыши на весь островок
    HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor // Курсор становится "ручкой" при наведении
    }

    // Фон с эффектом матового стекла и тенью
    Rectangle {
        id: bg
        anchors.fill: parent
        radius: NeuaTokens.radiusPill
        // Если мышь наведена — делаем фон чуть светлее (или прозрачнее)
        color: hover.hovered 
               ? Qt.lighter(NeuaTokens.surfaceTranslucent, 1.2) 
               : NeuaTokens.surfaceTranslucent
        
        // Плавная анимация смены цвета (займет 200мс)
        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        border.color: NeuaTokens.border
        border.width: 1

        // Тень
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, NeuaTokens.isDark ? 0.5 : 0.1)
            // Тень чуть увеличивается при наведении
            shadowVerticalOffset: hover.hovered ? 10 : 8
            shadowBlur: hover.hovered ? 1.2 : 1.0
            blurEnabled: false 
        }
    }

    // 1. Левая часть: Точка, обложка, текст
    Row {
        id: leftContent
        anchors.left: parent.left
        anchors.leftMargin: NeuaTokens.spacingMd
        anchors.verticalCenter: parent.verticalCenter
        spacing: NeuaTokens.spacingMd

        Rectangle {
            width: 8; height: 8
            radius: NeuaTokens.radiusPill
            color: NeuaTokens.accent
            anchors.verticalCenter: parent.verticalCenter
            
            // Пульсация красной точки
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { from: 1.0; to: 0.6; duration: 1000; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 0.6; to: 1.0; duration: 1000; easing.type: Easing.InOutQuad }
            }
        }

        Rectangle {
            width: 32; height: 32
            radius: NeuaTokens.radiusSm
            color: NeuaTokens.backgroundAlt
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                anchors.centerIn: parent
                text: "🎵"
                font.pixelSize: 16
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2
            Text {
                text: "Nothing Left"
                color: NeuaTokens.textPrimary
                font.family: NeuaTokens.fontFamily
                font.pixelSize: NeuaTokens.fontBody
                font.weight: NeuaTokens.weightBold
            }
            Text {
                text: "The Neighbourhood"
                color: NeuaTokens.textSecondary
                font.family: NeuaTokens.fontFamily
                font.pixelSize: NeuaTokens.fontCaption
            }
        }
    }

    // 2. Правая часть: Кнопки плеера
    Row {
        id: rightContent
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        spacing: NeuaTokens.spacingLg

        // --- Кнопка НАЗАД ---
        Item {
            width: 14; height: 14
            anchors.verticalCenter: parent.verticalCenter
            
            HoverHandler { id: prevHover; cursorShape: Qt.PointingHandCursor }
            
            Canvas {
                anchors.fill: parent
                // При наведении иконка немного увеличивается
                scale: prevHover.hovered ? 1.2 : 1.0
                Behavior on scale { NumberAnimation { duration: 150 } }
                
                // При наведении цвет становится ярким (accent), в покое - текст
                opacity: prevHover.hovered ? 1.0 : 0.8
                Behavior on opacity { NumberAnimation { duration: 150 } }
                
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = prevHover.hovered ? NeuaTokens.accent : NeuaTokens.textPrimary;
                    ctx.beginPath(); ctx.moveTo(10, 1); ctx.lineTo(1, 7); ctx.lineTo(10, 13); ctx.fill();
                }
            }
        }

        // --- Кнопка ПАУЗА ---
        Item {
            width: 14; height: 14
            anchors.verticalCenter: parent.verticalCenter
            
            HoverHandler { id: playHover; cursorShape: Qt.PointingHandCursor }
            
            Canvas {
                anchors.fill: parent
                scale: playHover.hovered ? 1.2 : 1.0
                Behavior on scale { NumberAnimation { duration: 150 } }
                opacity: playHover.hovered ? 1.0 : 0.8
                Behavior on opacity { NumberAnimation { duration: 150 } }
                
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = playHover.hovered ? NeuaTokens.accent : NeuaTokens.textPrimary;
                    ctx.fillRect(2, 1, 4, 12); ctx.fillRect(8, 1, 4, 12);
                }
            }
        }

        // --- Кнопка ВПЕРЕД ---
        Item {
            width: 14; height: 14
            anchors.verticalCenter: parent.verticalCenter
            
            HoverHandler { id: nextHover; cursorShape: Qt.PointingHandCursor }
            
            Canvas {
                anchors.fill: parent
                scale: nextHover.hovered ? 1.2 : 1.0
                Behavior on scale { NumberAnimation { duration: 150 } }
                opacity: nextHover.hovered ? 1.0 : 0.8
                Behavior on opacity { NumberAnimation { duration: 150 } }
                
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = nextHover.hovered ? NeuaTokens.accent : NeuaTokens.textPrimary;
                    ctx.beginPath(); ctx.moveTo(4, 1); ctx.lineTo(13, 7); ctx.lineTo(4, 13); ctx.fill();
                }
            }
        }
    }
}