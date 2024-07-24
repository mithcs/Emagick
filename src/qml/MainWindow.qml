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

    minimumWidth: 640
    minimumHeight: 480

    // maximumWidth: 1920
    // maximumHeight: 1080

    // Set the title of window
    title: "Emagick"

    // Set the background color
    // color: "#000000"

    // Set up mainImage
    Image {
        id: mainImage
        fillMode: Image.PreserveAspectFit

        // Center the image
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        // According to docs:
        // This is different than width, height as this opens image in AxB dimensions,
        // regardless of Image's width and height
        sourceSize.width: window.width / 1.3
        sourceSize.height: window.height / 1.3

        // Initialize with empty source
        source: ""
    }

    // A RowLayout to correctly position things...
    RowLayout {
        width: parent.width
        spacing: 2

        // Fill the width of row
        Item {
            Layout.fillWidth: true
        }

        // Set up Open Image button
        Button {
            id: openImage
            text: "Open Image"
            onClicked: openFile.open()

            // Set up content of button
            contentItem: Text {
                text: parent.text
                font: parent.font

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            // Set up background of button
            // background: Rectangle {
            //     border.width: 1
            //     radius: 2
            // }
        }

        // Set up Save Image button
        Button {
            id: saveImage
            text: "Save Image"
            onClicked: saveFile.open()

            // Set up content of button
            contentItem: Text {
                text: parent.text
                font: parent.font

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

            mainImage.source = "data:image/png;base64," + guiOps.getImageData()
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
