#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <Magick++.h>
#include <QObject>
#include <QString>
#include <QImage>
#include <QByteArray>

class MainWindow : public QObject
{
    Q_OBJECT
public:
    explicit MainWindow(QObject *parent = nullptr);

public slots:
    void loadImage(const QString &filePath);
    QString getImageData();  // Return data as QString

signals:
    void imageLoaded();

private:
    QImage convertToQImage(const Magick::Image &magickImage);
    QImage image;
};

#endif // MAINWINDOW_H
