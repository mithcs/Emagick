#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QObject>
#include <Magick++.h>

class MainWindow : public QObject
{
    Q_OBJECT
public:
    explicit MainWindow(QObject *parent = nullptr);

public slots:
    void openImage(const QString &imagePath);
    void saveImage(const QString &baseName);
    void applyCrop(int x, int y, int width, int height);
    void applyGrayscale();
    void applyGamma(float factor);
    void applyRotate(float degrees);
    void applyNegate();
    void applyNormalize();
    void applyOilPaint(int radius);
    void applyBrightness(float factor);

signals:
    void imageUpdated();

private:
    Magick::Image image;
    bool imageLoaded;
};

#endif // MAINWINDOW_H
