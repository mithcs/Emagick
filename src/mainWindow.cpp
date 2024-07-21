#include <QMessageBox>
#include "mainWindow.h"
#include "Emagick.h"

// Constructor
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent) {
    // Set the initial size of the main window
    resize(1280, 720);

    // Set up the UI elements

    // Create the QLabel to display the image
    imageLabel = new QLabel(this);
    // Center the image in the label
    imageLabel->setAlignment(Qt::AlignCenter);


    // Create buttons and combo box
    openButton = new QPushButton("Open Image", this);
    effectButton = new QPushButton("Apply Effect", this);
    saveButton = new QPushButton("Save Image", this);


    // Create and populate the combo box with effect options
    effectComboBox = new QComboBox(this);
    effectComboBox->addItem("Grayscale");
    effectComboBox->addItem("Normalize");
    effectComboBox->addItem("Oil Paint");


    // Create layouts
    buttonLayout = new QHBoxLayout();
    buttonLayout->addWidget(openButton);
    buttonLayout->addWidget(effectComboBox);
    buttonLayout->addWidget(effectButton);
    buttonLayout->addWidget(saveButton);

    mainLayout = new QVBoxLayout();
    mainLayout->addWidget(imageLabel);
    mainLayout->addLayout(buttonLayout);


    // Set the main layout in the central widget
    QWidget *centralWidget = new QWidget(this);
    centralWidget->setLayout(mainLayout);
    setCentralWidget(centralWidget);


    // Connect signals and slots
    connect(openButton, &QPushButton::clicked, this, &MainWindow::openImage);
    connect(effectButton, &QPushButton::clicked, this, &MainWindow::applyEffect);
    connect(saveButton, &QPushButton::clicked, this, &MainWindow::saveImage);
}

// Destructor
MainWindow::~MainWindow() {
}

// Slot to handle opening an image file
void MainWindow::openImage() {
    QString fileName = QFileDialog::getOpenFileName(this, "Open Image", "", "Images (*.png *.jpg *.jpeg *.bmp)");
    if (fileName.isEmpty())
        return;

    // Store the current file path
    currentFilePath = fileName;
    try {
        // Read the image using Magick++
        magickImage.read(fileName.toStdString());
        // Reduce size for preview
        magickImage.sample(Magick::Geometry("800x800"));
        // Create a preview image
        previewImage = magickImage;

        // Load the image into a QImage object for display
        qtImage = QImage(fileName);
        // Update the displayed image
        updateImageDisplay();
    } catch (Magick::Exception &error_) {
        QMessageBox::critical(this, "Error", QString::fromStdString(error_.what()));
    }
}

// Slot to handle applying the selected effect
void MainWindow::applyEffect() {
    try {
        // Get the selected effect
        QString selectedEffect = effectComboBox->currentText();

        // Apply the selected effect on the preview image
        if (selectedEffect == "Grayscale") {
            grayscaleImage(previewImage);
        } else if (selectedEffect == "Normalize") {
            normalizeImage(previewImage);
        } else if (selectedEffect == "Oil Paint") {
            oilPaintImage(previewImage, 3);
        }

        // Convert Magick::Image to QImage for preview
        Magick::Blob blob;
        previewImage.write(&blob, "PNG");
        qtPreviewImage.loadFromData((const uchar*)blob.data(), blob.length());

        // Update the preview image
        updatePreviewImage();
    } catch (Magick::Exception &error_) {
        QMessageBox::critical(this, "Error", QString::fromStdString(error_.what()));
    }
}

// Slot to handle saving the processed image
void MainWindow::saveImage() {
    QString fileName = QFileDialog::getSaveFileName(this, "Save Image", "", "Images (*.png *.jpg *.jpeg *.bmp)");
    if (fileName.isEmpty())
        return;

    try {
        // Apply the effect on the full-size image before saving
        QString selectedEffect = effectComboBox->currentText();
        if (selectedEffect == "Grayscale") {
            grayscaleImage(magickImage);
        } else if (selectedEffect == "Normalize") {
            normalizeImage(magickImage);
        } else if (selectedEffect == "Oil Paint") {
            oilPaintImage(magickImage, 3);
        }

        // Write the image to the specified file
        magickImage.write(fileName.toStdString());
    } catch (Magick::Exception &error_) {
        QMessageBox::critical(this, "Error", QString::fromStdString(error_.what()));
    }
}

// Helper function to update the displayed image in the QLabel
void MainWindow::updateImageDisplay() {
    if (!qtImage.isNull()) {
        imageLabel->setPixmap(QPixmap::fromImage(qtImage).scaled(imageLabel->size(), Qt::KeepAspectRatio));
    }
}

// Helper function to update the preview image in the QLabel
void MainWindow::updatePreviewImage() {
    if (!qtPreviewImage.isNull()) {
        imageLabel->setPixmap(QPixmap::fromImage(qtPreviewImage).scaled(imageLabel->size(), Qt::KeepAspectRatio));
    }
}
