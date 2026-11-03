// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 NeuaOS contributors

import QtQuick

Window {
    id: root
    width: 960
    height: 600
    visible: true
    title: "NeuaOS Shell"
    color: "#111111"

    Text {
        anchors.centerIn: parent
        text: "NeuaOS Shell — Phase 0 build OK"
        color: "#ffffff"
        font.pixelSize: 18
    }
}