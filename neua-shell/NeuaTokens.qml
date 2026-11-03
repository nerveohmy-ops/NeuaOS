pragma Singleton
import QtQuick

QtObject {
    property bool isDark: true

    // --- Colors ---
    readonly property color background: isDark ? "#0E0E10" : "#F2F2F4"
    readonly property color backgroundAlt: isDark ? "#16161A" : "#FFFFFF"
    readonly property color textPrimary: isDark ? "#F2F2F4" : "#1C1C21"
    readonly property color textSecondary: isDark ? "#9A9AA2" : "#5A5A62"
    readonly property color accent: "#E23A3A"
    readonly property color surfaceTranslucent: isDark ? Qt.rgba(0.11, 0.11, 0.13, 0.72) : Qt.rgba(1, 1, 1, 0.72)
    readonly property color border: isDark ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.08)

    // --- Spacing ---
    readonly property int spacingXs: 4
    readonly property int spacingSm: 8
    readonly property int spacingMd: 12
    readonly property int spacingLg: 16
    readonly property int spacingXl: 24
    readonly property int spacingXxl: 32

    // --- Radius ---
    readonly property int radiusSm: 8
    readonly property int radiusMd: 12
    readonly property int radiusPill: 999

    // --- Typography ---
    readonly property string fontFamily: "Inter"
    readonly property int fontCaption: 12
    readonly property int fontBody: 14
    readonly property int fontClock: 64
    readonly property int weightBold: Font.Bold
}