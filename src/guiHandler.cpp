#include <Magick++.h>
#include <QBuffer>
#include <QDebug>
#include <QImage>
#include <QByteArray>
#include <exception>

#include "guiHandler.h"

// Constructor for GuiHandler class
GuiHandler::GuiHandler(QObject *parent) : QObject(parent) {}

// Global instance of Magick::Image for image processing
Magick::Image mainImage;

void GuiHandler::loadImage(const QString &filePath) {
    try {
        // Attempt to read the image from the specified file path
        mainImage.read(filePath.toStdString());

        // Convert the loaded Magick::Image to QImage format for Qt usage
        image = convertToQImage();

        // Emit a signal indicating the image has been successfully loaded
        emit imageLoaded();
    } catch (const std::exception &error_) {
        qWarning() << "Failed to load image: " << error_.what();
    }
}

void GuiHandler::saveImage(const QString &filepath) {
    try {
        // Attempt to write the image to the specified file path
        mainImage.write(filepath.toStdString());
    } catch (const std::exception &error_) {
        qWarning() << "Failed to save image: " << error_.what();
    }
}

QString GuiHandler::getImageData() {
    if (image.isNull()) {
        // If the image is not loaded, return an empty string
        return QString();
    }

    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);

    // Save the QImage to the buffer in PNG format
    image.save(&buffer, "PNG");

    // Encode the image data in Base64 and return as a QString
    return QString::fromUtf8(byteArray.toBase64());
}

QImage GuiHandler::convertToQImage() {
    // Create a QImage with the same dimensions as the Magick::Image
    QImage qImage(mainImage.columns(), mainImage.rows(), QImage::Format_RGB888);

    // Iterate through each pixel of the Magick::Image
    for (int y = 0; y < mainImage.rows(); ++y) {
        for (int x = 0; x < mainImage.columns(); ++x) {
            // Get the color of the pixel from Magick::Image
            Magick::ColorRGB color = mainImage.pixelColor(x, y);

            // Set the corresponding pixel color in the QImage
            qImage.setPixel(x, y, qRgb(color.red() * 255, color.green() * 255, color.blue() * 255));
        }
    }

    // Return the populated QImage
    return qImage;
}
