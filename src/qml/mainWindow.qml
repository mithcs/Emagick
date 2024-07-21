import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Image Editor")

    // FileDialog to open an image
    FileDialog {
        id: openFileDialog
        title: "Open Image"
        nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp *.gif)"]
        onAccepted: {
            let filePath = openFileDialog.fileUrl.toLocalFile();
            if (filePath) {
                mainWindow.openImage(filePath);
            } else {
                console.log("No file selected");
            }
        }
        onRejected: {
            console.log("Open file dialog was canceled or failed");
        }
    }

    // FileDialog to save an image
    FileDialog {
        id: saveFileDialog
        title: "Save Image"
        nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp *.gif)"]
        onAccepted: {
            let filePath = saveFileDialog.fileUrl.toLocalFile();
            mainWindow.saveImage(filePath);
        }
    }

    Column {
        spacing: 10
        padding: 10

        Row {
            spacing: 10

            Button {
                text: "Open Image"
                onClicked: openFileDialog.open()
            }

            Button {
                text: "Save Image"
                onClicked: saveFileDialog.open()
            }
        }

        Row {
            spacing: 10

            Button {
                text: "Grayscale"
                onClicked: mainWindow.applyGrayscale()
            }

            Button {
                text: "Normalize"
                onClicked: mainWindow.applyNormalize()
            }

            Button {
                text: "Negate Colors"
                onClicked: mainWindow.applyNegate()
            }

            Button {
                text: "Oil Paint"
                onClicked: mainWindow.applyOilPaint(3)
            }

            Button {
                text: "Rotate"
                onClicked: mainWindow.applyRotate(90)
            }

            Button {
                text: "Change Gamma"
                onClicked: mainWindow.applyGamma(1.5)
            }

            Button {
                text: "Change Brightness"
                onClicked: mainWindow.applyBrightness(120)
            }

            Button {
                text: "Crop Image"
                onClicked: mainWindow.applyCrop(50, 50, 200, 200)
            }
        }

        Image {
            id: imageView
            width: 800
            height: 800
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Connections {
            target: mainWindow
            function onImageUpdated() {
                imageView.source = "file:///tmp/output_image.jpg";
            }
        }
    }
}
