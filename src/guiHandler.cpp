#include <Magick++.h>
#include <QBuffer>
#include <QDebug>
#include <QImage>
#include <QByteArray>
#include <QUrl>

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

    // Create a buffer
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);

    // Get the file extension
    std::string extension = mainImage.magick();

    // Save the QImage to the buffer
    try { 
        // image.save(&buffer, extension.c_str());
        image.save(&buffer, "PNG");
    } catch (const std::exception &error_) {
        qWarning() << "Unable to save image to buffer: " << error_.what();
    }

    // Encode the image data in Base64 and return as a QString
    return QString::fromUtf8(byteArray.toBase64());
}

QImage GuiHandler::convertToQImage() {
    // Create a blob to hold the image data
    Magick::Blob blob;
    
    // Write the image to the blob in a format suitable for QImage
    mainImage.write(&blob, "RGBA");

    // Create a QImage using the blob data
    QImage qImage((const uchar*)blob.data(), mainImage.columns(), mainImage.rows(), QImage::Format_RGBA8888);
    
    // Ensure the QImage does not share data with the blob
    // And therefore avoids seg fault
    return qImage.copy();
}
