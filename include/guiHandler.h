#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QObject>
#include <QString>
#include <QImage>
#include <QByteArray>

class GuiHandler : public QObject
{
    Q_OBJECT
public:
    explicit GuiHandler(QObject *parent = nullptr);


public slots:
    // Function to load an image from a file path
    void loadImage(const QString &filePath);

    // Function to save the current image to a file
    void saveImage(const QString &filePath);

    // Function to get the image data as a Base64 encoded string
    QString getImageData();

    // Function to normalize image
    bool applyNormalization();

    // Function to Oil Paint image


private:
    // Function to convert Magick::Image to QImage format for use in Qt
    QImage convertToQImage();

    // Instance of QImage for image in QT
    QImage image;
};

#endif // MAINWINDOW_H
