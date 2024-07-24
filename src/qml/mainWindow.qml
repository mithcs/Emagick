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
    width: 800
    height: 800

    // minimumWidth: 640
    // minimumHeight: 480

    // maximumWidth: 1920
    // maximumHeight: 1080

    // Set the title of window
    title: "Emagick"

    // Set the background color
    // color: "#000000"

    // Set up text
    Text {
        text: "Welcome to <b>Emagick!</b>"

        leftPadding: 15
        rightPadding: 15
        topPadding: 15

        horizontalAlignment: Text.AlignHCenter

        font.family: "Helvetica"
        font.pointSize: 16

        font.weight: 600

        color: "#88f"
    }

    // Set up mainImage
    Image {
        id: mainImage
        fillMode: Image.PreserveAspectFit

        // Center the image
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        // This is different than width, height as it opens image in AxB,
        // regardless of Image's width and height
        sourceSize.width: 800
        sourceSize.height: 800

        // Set default source
        // property var src = "data:image/png;base64," + mainWindow.getImageData()
        // console.log(src);
        source: ""  // Initialize with empty source
    }

    // A RowLayout to correctly position things...
    RowLayout {
        width: parent.width
        spacing: 2

        // Fill the width of row
        Item {
            Layout.fillWidth: true
        }

        // Set up Button
        Button {
            id: openImage
            text: "Open Image"
            onClicked: fileDialog.open()

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

        // Fill the width of row
        Item {
            Layout.fillWidth: true
        }
    }

    // Set up File Dialog
    FileDialog {
        id: fileDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]

        onAccepted: {
            // Load the image and set the source directly
            mainWindow.loadImage(selectedFile);
            var imageData = mainWindow.getImageData();  // Get the image data
            mainImage.source = "data:image/png;base64," + imageData;
        }
    }
}
