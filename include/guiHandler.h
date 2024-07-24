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

signals:
    // A signal to determine whether image is loaded or not
    void imageLoaded();

private:
    // Function to convert Magick::Image to QImage format for use in Qt
    QImage convertToQImage();

    QImage image;
};

#endif // MAINWINDOW_H
