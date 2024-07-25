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


// ############## BUTTON THEMES EXAMPLE ###############
//
// import QtQuick
// import QtQuick.Controls
//
// ApplicationWindow {
//     visible: true
//     width: 800
//     height: 800
//     title: "Modern Professional Buttons"
//
//     Grid {
//         columns: 2
//         spacing: 15
//         anchors.centerIn: parent
//
//         // 1. Basic Blue
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#007BFF" // Primary blue
//                 radius: 4
//                 border.color: "#0056b3"
//                 border.width: 1
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#0056b3" },
//                         GradientStop { position: 1.0; color: "#007BFF" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Basic"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 onClicked: {
//                     background.color = "#0056b3" // Darker blue on click
//                 }
//                 onReleased: {
//                     background.color = "#007BFF" // Reset color
//                 }
//             }
//         }
//
//         // 2. Soft Gray
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#6c757d" // Gray
//                 radius: 4
//                 border.color: "#5a6268"
//                 border.width: 1
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#5a6268" },
//                         GradientStop { position: 1.0; color: "#6c757d" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Gray"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 onClicked: {
//                     background.color = "#5a6268" // Darker gray on click
//                 }
//                 onReleased: {
//                     background.color = "#6c757d" // Reset color
//                 }
//             }
//         }
//
//         // 3. White Border
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "white"
//                 radius: 4
//                 border.color: "#007BFF"
//                 border.width: 2
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "white" },
//                         GradientStop { position: 1.0; color: "#e9ecef" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Border"
//                 color: "#007BFF"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 4. Rounded Green
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#28a745" // Green
//                 radius: 20
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#218838" },
//                         GradientStop { position: 1.0; color: "#28a745" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Rounded"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 5. Soft Shadow
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#343a40" // Dark gray
//                 radius: 4
//                 border.color: "#495057"
//                 border.width: 1
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#495057" },
//                         GradientStop { position: 1.0; color: "#343a40" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Shadow"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//             Rectangle {
//                 width: parent.width
//                 height: parent.height
//                 color: "black"
//                 radius: 4
//                 opacity: 0.2
//                 anchors.bottom: parent.bottom
//                 anchors.left: parent.left
//                 anchors.right: parent.right
//                 anchors.top: parent.top
//             }
//         }
//
//         // 6. Flat Teal
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#17a2b8" // Teal
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#117a8b" },
//                         GradientStop { position: 1.0; color: "#17a2b8" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Flat"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 7. Minimal Outline
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "transparent"
//                 radius: 4
//                 border.color: "#ffc107" // Amber
//                 border.width: 2
//             }
//             contentItem: Text {
//                 text: "Outline"
//                 color: "#ffc107"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 8. Elegant Gradient
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#6f42c1" },
//                         GradientStop { position: 1.0; color: "#5a329c" }
//                     ]
//                 }
//                 radius: 4
//             }
//             contentItem: Text {
//                 text: "Gradient"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 9. Classic Blue
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#007BFF" // Classic blue
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#0056b3" },
//                         GradientStop { position: 1.0; color: "#007BFF" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Classic"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 10. Subtle Hover
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#6c757d" // Gray
//                 radius: 4
//                 border.color: "#5a6268"
//                 border.width: 1
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#5a6268" },
//                         GradientStop { position: 1.0; color: "#6c757d" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Subtle"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 onClicked: {
//                     background.color = "#5a6268" // Darker gray on click
//                 }
//                 onReleased: {
//                     background.color = "#6c757d" // Reset color
//                 }
//             }
//         }
//
//         // 11. Black Flat
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#343a40" // Black
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#212529" },
//                         GradientStop { position: 1.0; color: "#343a40" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Black"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 12. Light Gray
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#f8f9fa" // Light gray
//                 radius: 4
//                 border.color: "#e2e6ea"
//                 border.width: 1
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#e2e6ea" },
//                         GradientStop { position: 1.0; color: "#f8f9fa" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Light"
//                 color: "#343a40"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 13. Soft Green
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#28a745" // Soft green
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#218838" },
//                         GradientStop { position: 1.0; color: "#28a745" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Soft"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 14. Deep Blue
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#003366" // Deep blue
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#002147" },
//                         GradientStop { position: 1.0; color: "#003366" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Deep"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 15. Light Blue
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#add8e6" // Light blue
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#87ceeb" },
//                         GradientStop { position: 1.0; color: "#add8e6" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Light"
//                 color: "#003366" // Dark blue text
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 16. Neutral Gray
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#b0bec5" // Neutral gray
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#9e9e9e" },
//                         GradientStop { position: 1.0; color: "#b0bec5" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Neutral"
//                 color: "#263238" // Darker gray text
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 17. Violet Edge
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "white"
//                 radius: 4
//                 border.color: "#8e44ad" // Violet
//                 border.width: 2
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "white" },
//                         GradientStop { position: 1.0; color: "#f2e6f5" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Violet"
//                 color: "#8e44ad"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 18. Modern Pink
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#e83e8c" // Pink
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#d63384" },
//                         GradientStop { position: 1.0; color: "#e83e8c" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Modern"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 19. Mint Green
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#20c997" // Mint green
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#1aa89a" },
//                         GradientStop { position: 1.0; color: "#20c997" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Mint"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 20. Orange Accent
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "white"
//                 radius: 4
//                 border.color: "#fd7e14" // Orange
//                 border.width: 2
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "white" },
//                         GradientStop { position: 1.0; color: "#ffe8d4" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Orange"
//                 color: "#fd7e14"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 21. Cool Gray
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#495057" // Cool gray
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#343a40" },
//                         GradientStop { position: 1.0; color: "#495057" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Cool"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 22. Fresh Blue
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#00bfff" // Fresh blue
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#0099cc" },
//                         GradientStop { position: 1.0; color: "#00bfff" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Fresh"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 23. Elegant Black
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#212529" // Elegant black
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#1d1d1d" },
//                         GradientStop { position: 1.0; color: "#212529" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Elegant"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 24. Soft Purple
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#d63384" // Soft purple
//                 radius: 4
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#c2185b" },
//                         GradientStop { position: 1.0; color: "#d63384" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Purple"
//                 color: "white"
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//
//         // 25. Cool Beige
//         Button {
//             width: 120
//             height: 40
//             background: Rectangle {
//                 color: "#f5f5f5" // Cool beige
//                 radius: 4
//                 border.color: "#ccc" // Light border
//                 border.width: 1
//                 gradient: Gradient {
//                     stops: [
//                         GradientStop { position: 0.0; color: "#f5f5f5" },
//                         GradientStop { position: 1.0; color: "#e2e2e2" }
//                     ]
//                 }
//             }
//             contentItem: Text {
//                 text: "Beige"
//                 color: "#212529" // Darker text
//                 anchors.centerIn: parent
//                 font.bold: true
//                 font.pointSize: 14
//             }
//         }
//     }
// }
