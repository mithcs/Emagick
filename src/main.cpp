#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "mainWindow.h"

int main(int argc, char **argv) {
    QApplication app(argc, argv);

    // Initialize ImageMagick
    Magick::InitializeMagick(*argv);

    // Create an instance of MainWindow
    MainWindow mainWindow;

    // Create a QML application engine
    QQmlApplicationEngine engine;

    // Expose MainWindow instance to QML
    engine.rootContext()->setContextProperty("mainWindow", &mainWindow);

    // Load the QML file
    engine.load(QUrl(QStringLiteral("qrc:/qml/mainWindow.qml")));

    // Check if the QML file loaded successfully
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
