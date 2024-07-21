#include "mainWindow.h"
#include "Emagick.h"
#include <QDebug>
#include <QFileInfo>

MainWindow::MainWindow(QObject *parent) : QObject(parent), imageLoaded(false) {}

void MainWindow::openImage(const QString &imagePath) {
    std::string path = imagePath.toStdString();
    if (readImage(path, image) == 0) {
        image.resize("800x800");
        imageLoaded = true;
        image.write("/tmp/output_image.jpg"); // Save the resized image for preview
        emit imageUpdated();
    } else {
        qDebug() << "Failed to open image";
    }
}

void MainWindow::saveImage(const QString &filePath) {
    if (imageLoaded) {
        std::string path = filePath.toStdString();
        if (writeImage(image, path) == 0) {
            qDebug() << "Image saved successfully.";
        } else {
            qDebug() << "Failed to save image";
        }
    }
}

void MainWindow::applyCrop(int x, int y, int width, int height) {
    if (imageLoaded) {
        if (cropImage(image, x, y, width, height) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to crop image";
        }
    }
}

void MainWindow::applyGrayscale() {
    if (imageLoaded) {
        if (grayscaleImage(image) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to apply grayscale";
        }
    }
}

void MainWindow::applyGamma(float factor) {
    if (imageLoaded) {
        if (changeGamma(image, factor) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to change gamma";
        }
    }
}

void MainWindow::applyRotate(float degrees) {
    if (imageLoaded) {
        if (rotateImage(image, degrees) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to rotate image";
        }
    }
}

void MainWindow::applyNegate() {
    if (imageLoaded) {
        if (negateColors(image) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to negate colors";
        }
    }
}

void MainWindow::applyNormalize() {
    if (imageLoaded) {
        if (normalizeImage(image) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to normalize image";
        }
    }
}

void MainWindow::applyOilPaint(int radius) {
    if (imageLoaded) {
        if (oilPaintImage(image, radius) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to apply oil paint effect";
        }
    }
}

void MainWindow::applyBrightness(float factor) {
    if (imageLoaded) {
        if (changeBrightness(image, factor) == 0) {
            image.write("/tmp/output_image.jpg");
            emit imageUpdated();
        } else {
            qDebug() << "Failed to change brightness";
        }
    }
}
