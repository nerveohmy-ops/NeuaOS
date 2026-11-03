// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 NeuaOS contributors

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QGuiApplication::setApplicationName("NeuaOS");
    QGuiApplication::setApplicationVersion("0.1.0");
    QGuiApplication::setOrganizationName("NeuaOS");

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("NeuaShell", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}