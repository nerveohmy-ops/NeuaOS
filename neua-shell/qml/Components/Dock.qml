import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import NeuaShell

Item {
    id: root
    width: parent.width - 40 // Почти на всю ширину с отступами
    height: 72

    // Фон дока (стеклянная плашка)
    Rectangle {
        id: dockBg
        anchors.fill: parent
        radius: NeuaTokens.radiusPill
        color: NeuaTokens.surfaceTranslucent
        border.color: NeuaTokens.border
        border.width: 1

        // Тень
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: Qt.rgba(0, 0, 0, NeuaTokens.isDark ? 0.6 : 0.15)
            shadowVerticalOffset: 8
            shadowBlur: 1.0
            blurEnabled: false
        }

        // Три группы элементов
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: NeuaTokens.spacingLg
            anchors.rightMargin: NeuaTokens.spacingLg
            spacing: NeuaTokens.spacingXl

            // --- 1. ЛЕВАЯ ГРУППА (системные) ---
            RowLayout {
                spacing: NeuaTokens.spacingSm
                Layout.alignment: Qt.AlignVCenter
                
                // Кнопка настроек
                Rectangle {
                    width: 40; height: 40
                    radius: NeuaTokens.radiusPill
                    color: NeuaTokens.isDark ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.05)
                    Text { anchors.centerIn: parent; text: "⚙"; font.pixelSize: 20; color: NeuaTokens.textPrimary }
                    
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    scale: hovered ? 1.1 : 1.0
                    Behavior on scale { NumberAnimation { duration: 150 } }
                }
                
                // Кнопка луны
                Rectangle {
                    width: 40; height: 40
                    radius: NeuaTokens.radiusPill
                    color: NeuaTokens.isDark ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.05)
                    Text { anchors.centerIn: parent; text: "🌙"; font.pixelSize: 20; color: NeuaTokens.textPrimary }
                    
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    scale: hovered ? 1.1 : 1.0
                    Behavior on scale { NumberAnimation { duration: 150 } }
                }
            }

            // Пружина, отталкивающая центральную группу
            Item { Layout.fillWidth: true }

            // --- 2. ЦЕНТРАЛЬНАЯ ГРУППА (приложения) ---
            RowLayout {
                spacing: NeuaTokens.spacingLg
                Layout.alignment: Qt.AlignVCenter
                
                Repeater {
                    model: ["⊞", "📁", "🔍", "🎵", "🎮", "✈", "⌨", "⚙"]
                    
                    delegate: Item {
                        width: 44; height: 44
                        
                        HoverHandler {
                            id: iconHover
                            cursorShape: Qt.PointingHandCursor
                        }

                        Rectangle {
                            anchors.fill: parent
                            radius: NeuaTokens.radiusPill
                            color: iconHover.hovered 
                                   ? (NeuaTokens.isDark ? Qt.rgba(1,1,1,0.15) : Qt.rgba(0,0,0,0.08)) 
                                   : "transparent"
                            Behavior on color { ColorAnimation { duration: 150 } }

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: 22
                                color: NeuaTokens.textPrimary
                            }
                        }

                        // Легкое увеличение иконки
                        scale: iconHover.hovered ? 1.15 : 1.0
                        Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutBack } }
                    }
                }
            }

            // Пружина, отталкивающая правую группу
            Item { Layout.fillWidth: true }

            // --- 3. ПРАВАЯ ГРУППА (быстрые действия) ---
            RowLayout {
                spacing: NeuaTokens.spacingSm
                Layout.alignment: Qt.AlignVCenter
                
                // Консоль
                Rectangle {
                    width: 40; height: 40
                    radius: NeuaTokens.radiusPill
                    color: NeuaTokens.isDark ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.05)
                    Text { anchors.centerIn: parent; text: ">_"; font.pixelSize: 14; color: NeuaTokens.textPrimary }
                    
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    scale: hovered ? 1.1 : 1.0
                    Behavior on scale { NumberAnimation { duration: 150 } }
                }
                
                // Звук (группа с ползунком)
                Rectangle {
                    width: 100; height: 40
                    radius: NeuaTokens.radiusPill
                    color: NeuaTokens.isDark ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.05)
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        spacing: 4
                        
                        Text { text: "🔈"; font.pixelSize: 14; Layout.leftMargin: 8; color: NeuaTokens.textPrimary }
                        
                        // Ползунок громкости
                        Rectangle {
                            Layout.fillWidth: true
                            height: 4
                            radius: 2
                            color: Qt.rgba(1,1,1,0.2)
                            
                            Rectangle {
                                width: parent.width * 0.7 // 70% громкости
                                height: parent.height
                                radius: 2
                                color: NeuaTokens.textPrimary
                            }
                        }
                    }
                }
                
                // Батарея
                Rectangle {
                    width: 40; height: 40
                    radius: NeuaTokens.radiusPill
                    color: NeuaTokens.isDark ? Qt.rgba(1,1,1,0.1) : Qt.rgba(0,0,0,0.05)
                    Text { anchors.centerIn: parent; text: "🔋"; font.pixelSize: 18; color: NeuaTokens.textPrimary }
                    
                    HoverHandler { cursorShape: Qt.PointingHandCursor }
                    scale: hovered ? 1.1 : 1.0
                    Behavior on scale { NumberAnimation { duration: 150 } }
                }
            }
        }
    }
}