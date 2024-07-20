#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFileDialog>
#include <QImage>
#include <QPixmap>
#include <QComboBox>
#include <Magick++.h>

// MainWindow class definition inheriting from QMainWindow
class MainWindow : public QMainWindow {
    // This macro is required for all classes that define signals or slots
    Q_OBJECT

public:
    // Constructor and Destructor
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    // Slot to handle opening an image file
    void openImage();

    // Slot to handle applying the selected effect
    void applyEffect();

    // Slot to handle saving the processed image
    void saveImage();

private:
    // Helper function to update the displayed image in the QLabel
    void updateImageDisplay();

    // Helper function to update the preview image in the QLabel
    void updatePreviewImage();

    // QLabel to display the image
    QLabel *imageLabel;

    // QImage object for the original image
    QImage qtImage;

    // QImage object for the preview image
    QImage qtPreviewImage;

    // Magick++ Image object for the original image
    Magick::Image magickImage;

    // Magick++ Image object for the preview image
    Magick::Image previewImage;

    // Button to open an image file
    QPushButton *openButton;

    // Button to apply the selected effect
    QPushButton *effectButton;

    // Button to save the processed image
    QPushButton *saveButton;

    // ComboBox to select the effect to apply
    QComboBox *effectComboBox;

    // Main layout for the window
    QVBoxLayout *mainLayout;

    // Layout for the buttons and combo box
    QHBoxLayout *buttonLayout;

    // Current file path of the opened image
    QString currentFilePath;
};

#endif // MAINWINDOW_H
