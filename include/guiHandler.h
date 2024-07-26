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

    // Function to Oil Paint image
    // TODO: Add me


private:
    // Function to convert Magick::Image to QImage format for use in Qt
    QImage convertToQImage();

    // Instance of QImage for image in QT
    QImage image;

    // Global instance of Magick::Image for image processing
    Magick::Image mainImage;
};

#endif // MAINWINDOW_H
