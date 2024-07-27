#include <QBuffer>
#include <QDebug>
#include <QImage>
#include <QUrl>
#include <QImageWriter>

#include "guiHandler.h"
#include "Emagick.h"

// Constructor for GuiHandler class
GuiHandler::GuiHandler(QObject *parent) : QObject(parent) {}


// ##############################################
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

    // Adjust quality as needed (0-100, where lower means more compression and less quality)
    writer.setQuality(75);
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

QString GuiHandler::updatedImage() {
    image = convertToQImage();

    return "data:image/jpeg;base64," + getImageData();
}


// ######################################################################

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


bool GuiHandler::applyNormalization() {
    if (!normalizeImage(mainImage)) {
        qWarning() << "Unable to normalize image";
        return false;
    }

    return true;
}

bool GuiHandler::applyGrayscale() {
    if (!grayscaleImage(mainImage)) {
        qWarning() << "Unable to grayscale image";
        return false;
    }

    return true;
}

bool GuiHandler::applyNegation() {
    if (!negateColors(mainImage)) {
        qWarning() << "Unable to negate colors";
        return false;
    }

    return true;
}

bool GuiHandler::applyDespeckle() {
    if (!despeckleImage(mainImage)) {
        qWarning() << "Unable to despeckle image";
        return false;
    }

    return true;
}

bool GuiHandler::applyEqualization() {
    if (!equalizeImage(mainImage)) {
        qWarning() << "Unable to equalize image";
        return false;
    }

    return true;
}

bool GuiHandler::applyErasure() {
    if (!eraseImage(mainImage)) {
        qWarning() << "Unable to erase image";
        return false;
    }

    return true;
}

bool GuiHandler::applyFlip() {
    if (!flipImage(mainImage)) {
        qWarning() << "Unable to flip image";
        return false;
    }

    return true;
}

bool GuiHandler::applyFlop() {
    if (!flopImage(mainImage)) {
        qWarning() << "Unable to flop image";
        return false;
    }

    return true;
}

bool GuiHandler::applyMagnification() {
    if (!magnifyImage(mainImage)) {
        qWarning() << "Unable to magnify image";
        return false;
    }

    return true;
}

bool GuiHandler::applyMinification() {
    if (!minifyImage(mainImage)) {
        qWarning() << "Unable to minify image";
        return false;
    }

    return true;
}

bool GuiHandler::applyTrim() {
    if (!trimImage(mainImage)) {
        qWarning() << "Unable to trim edges";
        return false;
    }

    return true;
}

bool GuiHandler::applyBrightness(const float factor) {
    if (!changeBrightness(mainImage, factor)) {
        qWarning() << "Unable to change brightness";
        return false;
    }

    return true;
}

bool GuiHandler::applyNoise(const int iNoiseType) {
    Magick::NoiseType noiseType;

    switch (iNoiseType) {
        case 0: noiseType = Magick::UniformNoise;
                break;
        case 1: noiseType = Magick::GaussianNoise;
                break;
        case 2: noiseType = Magick::MultiplicativeGaussianNoise;
                break;
        case 3: noiseType = Magick::ImpulseNoise;
                break;
        case 4: noiseType = Magick::LaplacianNoise;
                break;
        case 5: noiseType = Magick::PoissonNoise;
                break;
        default:qWarning() << "Unknown NoiseType";
    }

    if (!addNoise(mainImage, noiseType)) {
        qWarning() << "Unable to add noise";
        return false;
    }

    return true;
}

bool GuiHandler::applyEdge(const float edge) {
    if (!edgeImage(mainImage, edge)) {
        qWarning() << "Unable to highlight edge";
        return false;
    }

    return true;
}
