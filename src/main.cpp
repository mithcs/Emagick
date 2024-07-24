#include <Magick++.h>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "guiHandler.h"

int main(int argc, char **argv) {
    QApplication app(argc, argv);

    // Initialize ImageMagick
    Magick::InitializeMagick(*argv);

    // Create an instance of GuiHandler
    GuiHandler guiOps;

    // Create a QML application engine
    QQmlApplicationEngine engine;

    // Expose MainWindow instance to QML
    engine.rootContext()->setContextProperty("guiOps", &guiOps);

    // Load the QML file
    engine.load(QUrl(QStringLiteral("qrc:/qml/MainWindow.qml")));

    // Check if the QML file loaded successfully
    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}
