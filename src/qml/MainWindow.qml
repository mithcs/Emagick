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

        Item {
            width: mainImage.width
            height: mainImage.height
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: mainImage
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                width: window.width / 1.5
                height: window.height / 1.5
                source: ""
            }

            Rectangle {
                id: selectionRectangle
                color: "transparent"
                border.color: "blue"
                border.width: 2
                visible: false
                width: 0
                height: 0
                x: 0
                y: 0

                MouseArea {
                    id: selectionMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.CrossCursor

                    onPressed: {
                        if (cropButton.croppingMode) {
                            // Initialize the rectangle from the current mouse position
                            startX = mouseX
                            startY = mouseY
                            selectionRectangle.x = startX
                            selectionRectangle.y = startY
                            selectionRectangle.width = 0
                            selectionRectangle.height = 0
                            selectionRectangle.visible = true

                            // Log starting position
                            console.log("Started at: ", startX, startY);
                        }
                    }

                    onPositionChanged: {
                        if (cropButton.croppingMode && selectionRectangle.visible) {
                            // Calculate rectangle properties based on mouse position
                            var currentX = mouseX
                            var currentY = mouseY

                            selectionRectangle.x = Math.min(startX, currentX)
                            selectionRectangle.y = Math.min(startY, currentY)
                            selectionRectangle.width = Math.abs(currentX - startX)
                            selectionRectangle.height = Math.abs(currentY - startY)

                            console.log("Position Changed at: ", currentX, currentY, "Width, Height -> ", selectionRectangle.width, selectionRectangle.height);
                        }
                    }

                    onReleased: {
                        if (cropButton.croppingMode) {
                            cropButton.croppingMode = false
                            console.log("Crop area geometry: x=" + selectionRectangle.x + ", y=" + selectionRectangle.y + ", width=" + selectionRectangle.width + ", height=" + selectionRectangle.height)

                            // Call the function to crop image using these dimensions
                            if (guiOps.applyCrop(selectionRectangle.width, selectionRectangle.height, selectionRectangle.x, selectionRectangle.y)) {
                                console.log("Cropping applied, updating image source");
                                // Update image source only if cropping was successful
                                mainImage.source = guiOps.updatedImage()
                            } else {
                                console.log("Cropping failed, no update to image source");
                            }

                            // Reset all the properties to 0/false
                            selectionRectangle.visible = false
                            selectionRectangle.x = 0
                            selectionRectangle.y = 0
                            selectionRectangle.width = 0
                            selectionRectangle.height = 0
                        }
                    }

                    // Properties to store initial mouse press position
                    property int startX: 0
                    property int startY: 0
                }
            }
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
    //  Erase, Flip, Flop, Magnify, Minify, Trim, Add noise
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

                width: parent.width

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

                width: parent.width

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

                width: parent.width

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

            Dial {
                id: rotateDial

                from: 0
                value: 0
                to: 360

                stepSize: 1

                width: rotate.width * 1
                height: rotate.height * 3

                property int rotateDegrees: 0

                wrap: true

                onValueChanged: {
                    if (value == 360) {
                        value = 0
                    }
                }

                anchors.horizontalCenter: parent.horizontalCenter

                onMoved: {
                    rotateDegrees = rotateDial.value
                }
            }

            Text {
                id: rotateText

                text: "<b>" + rotateDial.rotateDegrees + "</b>: Degrees"

                anchors.horizontalCenter: parent.horizontalCenter

                font.pointSize: 10

                color: "black"
            }

            Button {
                id: rotate

                text: "Rotate Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyRotation(rotateDial.rotateDegrees)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }
        }
    }


    Item {
        id: operationsItem3

        width: parent.width

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.topMargin: parent.height / 15

        anchors.top: imageItem.bottom
        anchors.bottom: parent.bottom

        RowLayout {
            width: parent.width
            spacing: parent.width / 40

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }

            Column {
                width: parent.width

                spacing: parent.height / 50

                Slider {
                    id: brightnessSlider

                    from: -100
                    value: 0
                    to: 100

                    anchors.horizontalCenter: parent.horizontalCenter

                    property real brightnessFactor: 0

                    snapMode: Slider.SnapAlways
                    stepSize: 5

                    onMoved: {
                        brightnessSlider.brightnessFactor = value
                    }
                }

                Text {
                    text: "Brightness Factor: <b>" + brightnessSlider.brightnessFactor + "</b>"

                    anchors.horizontalCenter: parent.horizontalCenter

                    font.pointSize: 10

                    color: "black"
                }
            }

            Button {
                id: contrastAndBrightness
                text: "Change Brightness/Contrast"

                onClicked: {
                    guiOps.applyBrightnessContrast(brightnessSlider.brightnessFactor, contrastSlider.contrastFactor)

                    // Update image
                    mainImage.source = guiOps.updatedImage()
                }
            }

            Column {
                width: parent.width

                spacing: parent.height / 40

                Slider {
                    id: contrastSlider

                    from: -100
                    value: 0
                    to: 100

                    anchors.horizontalCenter: parent.horizontalCenter

                    property real contrastFactor: 0

                    snapMode: Slider.SnapAlways
                    stepSize: 5

                    onMoved: {
                        contrastSlider.contrastFactor = value
                    }
                }

                Text {
                    text: "Contrast Factor: <b>" + contrastSlider.contrastFactor + "</b>"

                    anchors.horizontalCenter: parent.horizontalCenter

                    font.pointSize: 10

                    color: "black"
                }
            }

            Button {
                id: cropButton
                text: "Crop Image"

                property bool croppingMode: false

                onClicked: {
                    croppingMode = true
                    selectionRectangle.visible = false // Hide initially; will show on mouse press
                }
            }

            // Fill the width of row
            Item {
                Layout.fillWidth: true
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
