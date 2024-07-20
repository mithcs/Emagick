#include <iostream>
#include <Magick++.h>
#include <QApplication>

#include "mainWindow.h"

#include "Emagick.h"

using namespace std;

int main(int argc, char **argv) {
    QApplication app(argc, argv);
    // Initialize Magick
    Magick::InitializeMagick(*argv);

    MainWindow mainWindow;
    mainWindow.show();

    return app.exec();
}
