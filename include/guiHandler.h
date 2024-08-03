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
    QString getImageData();

    // Function to update image
    QString updatedImage();


    // Function to load an image from a file path
    void loadImage(const QString &filePath);

    // Function to save the current image to a file
    void saveImage(const QString &filePath);

    // Function to normalize image
    bool applyNormalization();

    // Function to grayscale image
    bool applyGrayscale();

    // Function to negate colors
    bool applyNegation();

    // Function to despeckle image
    bool applyDespeckle();

    // Function to equalize image
    bool applyEqualization();

    // Function to erase image
    bool applyErasure();

    // Function to flip image
    bool applyFlip();

    // Function to flip image
    bool applyFlop();

    // Function to magnify image
    bool applyMagnification();

    // Function to minify image
    bool applyMinification();

    // Function to trim image
    bool applyTrim();

    // Function to apply noise
    bool applyNoise(const int iNoiseType);

    // Function to apply edge
    bool applyEdge(const float radius);

    // Function to change gamma
    bool applyGamma(const float factor);

    // Function to apply noise reduction
    bool applyNoiseReduction(const float order);

    // Function to apply rotation
    bool applyRotation(const float degres);

    // Function to change brightness and/or contrast
    bool applyBrightnessContrast(const float brightness, const float contrast);

private:
    // Function to convert Magick::Image to QImage format for use in Qt
    QImage convertToQImage();

    // Instance of QImage for image in QT
    QImage image;

    // Global instance of Magick::Image for image processing
    Magick::Image mainImage;
};

#endif // MAINWINDOW_H
