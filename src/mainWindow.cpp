#include "mainWindow.h"
#include <QBuffer>
#include <QDebug>
#include <QImage>
#include <QByteArray>

MainWindow::MainWindow(QObject *parent) : QObject(parent) {}

void MainWindow::loadImage(const QString &filePath)
{
    try {
        Magick::Image magickImage;
        magickImage.read(filePath.toStdString());

        image = convertToQImage(magickImage);
        emit imageLoaded();
    } catch (const std::exception &e) {
        qWarning() << "Failed to load image:" << e.what();
    }
}

QString MainWindow::getImageData()
{
    if (image.isNull()) {
        return QString();
    }

    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    image.save(&buffer, "PNG");
    return QString::fromUtf8(byteArray.toBase64());
}

QImage MainWindow::convertToQImage(const Magick::Image &magickImage)
{
    QImage qImage(magickImage.columns(), magickImage.rows(), QImage::Format_RGB888);

    for (int y = 0; y < magickImage.rows(); ++y) {
        for (int x = 0; x < magickImage.columns(); ++x) {
            Magick::ColorRGB color = magickImage.pixelColor(x, y);
            qImage.setPixel(x, y, qRgb(color.red() * 255, color.green() * 255, color.blue() * 255));
        }
    }

    return qImage;
}
