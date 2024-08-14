#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QObject>
#include <QString>
#include <QImage>
#include <QByteArray>
#include <Magick++.h>

class GuiHandler : public QObject
{
    Q_OBJECT
public:
    explicit GuiHandler(QObject *parent = nullptr);


public slots:
    // Function to get the image data as a Base64 encoded string
    Q_INVOKABLE QString getImageData();

    // Function to update image
    Q_INVOKABLE QString updatedImage();


    // Function to load an image from a file path
    Q_INVOKABLE void loadImage(const QString &filePath);

    // Function to save the current image to a file
    Q_INVOKABLE void saveImage(const QString &filePath);

    // Function to normalize image
    Q_INVOKABLE bool applyNormalization();

    // Function to grayscale image
    Q_INVOKABLE bool applyGrayscale();

    // Function to negate colors
    Q_INVOKABLE bool applyNegation();

    // Function to despeckle image
    Q_INVOKABLE bool applyDespeckle();

    // Function to equalize image
    Q_INVOKABLE bool applyEqualization();

    // Function to erase image
    Q_INVOKABLE bool applyErasure();

    // Function to flip image
    Q_INVOKABLE bool applyFlip();

    // Function to flip image
    Q_INVOKABLE bool applyFlop();

    // Function to magnify image
    Q_INVOKABLE bool applyMagnification();

    // Function to minify image
    Q_INVOKABLE bool applyMinification();

    // Function to trim image
    Q_INVOKABLE bool applyTrim();

    // Function to apply noise
    Q_INVOKABLE bool applyNoise(const int iNoiseType);

    // Function to apply edge
    Q_INVOKABLE bool applyEdge(const float radius);

    // Function to change gamma
    Q_INVOKABLE bool applyGamma(const float factor);

    // Function to apply noise reduction
    Q_INVOKABLE bool applyNoiseReduction(const float order);

    // Function to apply rotation
    Q_INVOKABLE bool applyRotation(const float degres);

    // Function to change brightness and/or contrast
    Q_INVOKABLE bool applyBrightnessContrast(const float brightness, const float contrast);

    // Function to crop image
    Q_INVOKABLE bool applyCrop(const int width, const int height, const int offsetx, const int offsety);

    // Function to get file name
    Q_INVOKABLE QString getFileName();

private:
    // Function to convert Magick::Image to QImage format for use in Qt
    QImage convertToQImage();

    // Instance of QImage for image in QT
    QImage image;

    // Global instance of Magick::Image for image processing
    Magick::Image mainImage;
};

#endif // MAINWINDOW_H
