#include <Magick++.h>
#include <QBuffer>
#include <QDebug>
#include <QImage>
#include <QByteArray>
#include <QUrl>
#include <QImageWriter>
#include <qlogging.h>

#include "guiHandler.h"
#include "Emagick.h"

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
    } catch (const std::exception &error_) {
        qWarning() << "Failed to load image: " << error_.what();
    }
}

void GuiHandler::saveImage(const QString &filepath) {
    try {
        // Make file path readable by magick
        QString localFilePath = QUrl(filepath).toLocalFile();

        // Attempt to write the image to the specified file path
        mainImage.write(localFilePath.toStdString());
    } catch (const std::exception &error_) {
        qWarning() << "Failed to save image: " << error_.what();
    }
}

QString GuiHandler::getImageData() {
    if (image.isNull()) {
        // If the image is not loaded, return an empty string
        return QString();
    }

    // Create a QByteArray and use QBuffer for the image
    QByteArray byteArray;
    QBuffer buffer(&byteArray);

    if (!buffer.open(QIODevice::WriteOnly)) {
        qWarning() << "Unable to open buffer for writing";
        return QString();
    }

    // Save the QImage to the buffer in JPEG format with reduced quality for performance
    QImageWriter writer(&buffer, "JPEG");
    writer.setQuality(60); // Adjust quality as needed (0-100, where lower means more compression and less quality)
    if (!writer.write(image)) {
        qWarning() << "Unable to write image to buffer: " << writer.errorString();
        return QString();
    }

    // Encode the image data in Base64 without intermediate copies
    return QString::fromUtf8(byteArray.toBase64(QByteArray::Base64Encoding));
}

QImage GuiHandler::convertToQImage() {
    // Create new Magick::Image instance for conversion to RGBA
    Magick::Image newImage = mainImage;

    // Create a blob to hold the image data
    Magick::Blob blob;
    
    // Write the image to the blob in a format suitable for QImage
    newImage.write(&blob, "RGBA");

    // Create a QImage using the blob data
    QImage qImage((const uchar*)blob.data(), newImage.columns(), newImage.rows(), QImage::Format_RGBA8888);
    
    // Ensure the QImage does not share data with the blob
    // And therefore avoids seg fault
    return qImage.copy();
}

bool GuiHandler::applyNormalization() {
    if (!normalizeImage(mainImage)) {
        qWarning() << "Unable to normalize image";
        return false;
    }
    return true;
}
