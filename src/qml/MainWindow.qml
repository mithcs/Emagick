import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

// Window type for simple GUI
Window {
    // Set id
    id: window

    // Make it visible
    visible: true

    // Set up geometry
    width: Screen.width / 1.3
    height: Screen.height / 1.3

    // Set the title of window
    title: "Emagick"

    // Set up mainImage
    Image {
        id: mainImage
        fillMode: Image.PreserveAspectFit

        // Center the image
        anchors.centerIn: parent

        // Set vertical center offset
        anchors.verticalCenterOffset: -20

        // According to docs:
        // This is different than width, height as this opens image in AxB dimensions,
        // regardless of Image's width and height
        sourceSize.width: window.width / 1.5
        sourceSize.height: window.height / 1.5

        // Initialize with empty source
        source: ""
    }

    RowLayout {
        width: parent.width
        spacing: 20

        // Fill the width of row
        Item {
            Layout.fillWidth: true
        }

        // Set up Open Image button
        Button {
            id: openImage

            Layout.topMargin: 15
            onClicked: openFile.open()

            contentItem: Text {
                text: "Open Image"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Set up Save Image button
        Button {
            id: saveImage

            Layout.topMargin: 15
            onClicked: saveFile.open()

            contentItem: Text {
                text: "Save Image"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        // Fill the width of row
        Item {
            Layout.fillWidth: true
        }
    }


    // Set up openFile Dialog
    FileDialog {
        id: openFile
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        nameFilters: ["Images (*.jpg *.jpeg *.png *.bmp)", "All Files (*)"]

        onAccepted: {
            // Load the image and set the source directly
            guiOps.loadImage(selectedFile)

            mainImage.source = "data:image/jpeg;base64," + guiOps.getImageData()
        }
    }

    // Set up saveFile Dialog
    FileDialog {
        id: saveFile
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]

        fileMode: FileDialog.SaveFile

        nameFilters: ["Images (*.jpeg *.jpg *.png *.bmp)", "All Files (*)"]

        onAccepted: {
            guiOps.saveImage(selectedFile)
        }
    }
}
