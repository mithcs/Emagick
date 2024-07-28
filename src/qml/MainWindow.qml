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

    // Container for image
    Item {
        id: imageItem

        width: window.width / 1.5
        height: window.height / 1.5

        // Center the item
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -45

        // Column for Image
        Column {
            width: parent.width

            // Space between text and image
            spacing: 3

            Text {
                id: nameAndRes
                text: "IMAGE NAME + RESOLUTION HERE"
                font.italic: true
                color: "blue"

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: mainImage
                fillMode: Image.PreserveAspectFit

                anchors.horizontalCenter: parent.horizontalCenter

                // Set width and height
                width: window.width / 1.5
                height: window.height / 1.5

                // Initialize with empty source
                source: ""
            }
        }
    }

    // Container for Open/Save Image button
    Item {
        id: openCloseItem
        width: parent.width

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 25
        anchors.top: parent.top

        RowLayout {
            width: parent.width
            spacing: parent.width / 40

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }

            // Set up Open Image button
            Button {
                id: openImage
                text: "Open Image"

                onClicked: openFile.open()
            }

            // Set up Save Image button
            Button {
                id: saveImage
                text: "Save Image"

                onClicked: saveFile.open()
            }

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }
        }
    }


    // Container for left side operational buttons & stuff:
    //  Normalize, Grayscale, Negate, Despeckle, Equalize,
    //  Erase, Flip, Flop, Magnify, Minify, Trim, Change Brightness,
    //  Add Noise
    Item {
        id: operationsItem1

        // Anchors for setting margin
        anchors.left: parent.left
        anchors.top: parent.top

        anchors.leftMargin: parent.width / 50

        anchors.topMargin: parent.height / 9
        anchors.bottomMargin: parent.height / 9

        width: (parent.width - imageItem.width) / 2.2 - anchors.leftMargin
        height: parent.height - anchors.topMargin

        Column {
            spacing: parent.height / 50
            width: parent.width

            Button {
                id: normalize
                text: "Normalize Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyNormalization()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: grayscale
                text: "Grayscale Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyGrayscale()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: negate
                text: "Negate Colors"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyNegation()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: despeckle
                text: "Despeckle Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyDespeckle()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: equalize
                text: "Equalize Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyEqualization()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: erase
                text: "Erase Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyErasure()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: flip
                text: "Flip Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyFlip()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: flop
                text: "Flop Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyFlop()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: magnify
                text: "Magnify Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyMagnification()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: minify
                text: "Minify Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyMinification()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: trim
                text: "Trim Edges"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyTrim()

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }


            Slider {
                id: brightnessSlider
                width: parent.width

                from: 0
                value: 100
                to: 200

                property real brightnessFactor: 100

                snapMode: Slider.SnapAlways
                stepSize: 5

                onMoved: {
                    brightnessSlider.brightnessFactor = value
                }
            }

            Button {
                id: brightness
                text: "Change Brightness"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyBrightness(brightnessSlider.brightnessFactor)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Text {
                text: "Brightness Factor: <b>" + brightnessSlider.brightnessFactor + "</b>"

                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: 10

                color: "black"
            }

            ComboBox {
                id: noiseType

                anchors.horizontalCenter: parent.horizontalCenter

                currentIndex: 1

                editable: true
                model: ["Uniform Noise", "Gaussian Noise", "Multiplicative Gaussian Noise", "Impulse Noise", "Laplacian Noise", "Poisson Noise"]
            }

            Button {
                id: noise

                text: "Add noise"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyNoise(noiseType.currentIndex)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

        }
    }

    // Container for right side operational buttons & stuff:
    Item {
        id: operationsItem2

        // Anchors for setting margin
        // anchors.left: mainImage.right
        anchors.right: parent.right

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.topMargin: parent.height / 9
        anchors.bottomMargin: parent.height / 9

        anchors.rightMargin: parent.width / 50
        anchors.leftMargin: parent.width / 50

        width: (parent.width - imageItem.width) / 2.2 - anchors.rightMargin
        height: parent.height - anchors.topMargin


        Column {
            spacing: parent.height / 50
            width: parent.width

            Slider {
                id: edgeSlider

                from: 1
                value: 3
                to: 15

                snapMode: Slider.SnapAlways
                stepSize: 1

                anchors.horizontalCenter: parent.horizontalCenter

                property real edgeValue: 5

                onMoved: {
                    edgeValue = value
                }
            }

            Text {
                text: "Edge Value: <b>" + edgeSlider.edgeValue + "</b>"

                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: 10

                color: "black"
            }

            Button {
                id: edge

                text: "Highlight Edges"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyEdge(edgeSlider.edgeValue)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Slider {
                id: gammaSlider

                from: 1
                value: 3
                to: 10

                snapMode: Slider.SnapAlways
                stepSize: 0.5

                anchors.horizontalCenter: parent.horizontalCenter

                property real gammaValue: 2.5

                onMoved: {
                    gammaValue = value
                }
            }

            Text {
                text: "Gamma Value: <b>" + gammaSlider.gammaValue + "</b>"

                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: 10

                color: "black"
            }

            Button {
                id: gamma

                text: "Change gamma"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyGamma(gammaSlider.gammaValue)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Slider {
                id: noiseReductionSlider

                from: 1
                value: 3
                to: 10

                snapMode: Slider.SnapAlways
                stepSize: 0.5

                anchors.horizontalCenter: parent.horizontalCenter

                property real noiseReductionOrder: 3

                onMoved: {
                    noiseReductionOrder = value
                }
            }

            Text {
                text: "Noise reduction order: <b>" + noiseReductionSlider.noiseReductionOrder + "</b>"

                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: 10

                color: "black"
            }

            Button {
                id: noiseReduction

                text: "Reduce Noise"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyNoiseReduction(noiseReductionSlider.noiseReductionOrder)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            // TODO: FIX ME
            Rectangle {
                width: parent.width / 20

                color: "Lightgray"
                radius: 2
                border.color: "darkgrey"
                border.width: 1

                TextInput {
                    id: rotateInput

                    Text {
                        text: "Enter degrees"
                        color: "#aaa"
                        visible: !rotateInput.text
                    }

                    anchors.horizontalCenter: parent.horizontalCenter

                    property real rotateDegrees: 0

                    inputMethodHints: Qt.ImhFormattedNumbersOnly

                    onTextChanged: {
                        rotateDegrees = rotateInput.text
                    }
                }
            }

            Button {
                id: rotate

                text: "Rotate Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyRotation(rotateInput.rotateDegrees)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

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

            // Update image
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
