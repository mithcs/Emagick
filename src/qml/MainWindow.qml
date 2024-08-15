import QtCore                       // For StandardPaths
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts

// Window type for simple GUI
Window {
    // Set id
    id: window

    // Make it visible
    visible: true

    // Set the title of window
    title: "Emagick"

    // Set theme and color
    Material.theme: Material.Dark
    Material.accent: Material.DeepPurple
    color: "#202020"

    // Set up width and height
    width: Screen.width / 1.3
    height: Screen.height / 1.3

    // Global properties
    property string textColor: "white"

    // Container for image
    Item {
        id: imageItem

        width: window.width / 1.3
        height: window.height / 1.3

        // Center the item
        anchors.centerIn: parent
        // anchors.verticalCenterOffset: -45

        // Column for Image
        Column {
            id: imageCol

            width: parent.width
            height: parent.height

            // Space between text and image
            spacing: 1

            Text {
                id: nameAndRes

                // property var imageName: "Select File"
                
                text: "IMAGE NAME" + " + RESOLUTION HERE"
                font.italic: true
                color: "steelblue"

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: mainImage
                fillMode: Image.PreserveAspectFit

                anchors.horizontalCenter: parent.horizontalCenter

                // Set width and height
                width: imageCol.width / 1.2
                height: imageCol.height / 1.2

                // Initialize with empty source
                source: ""
            }
        }
    }

    // Container for Open/Save Image button
    Item {
        id: openCloseItem

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.topMargin: window.height / 30

        anchors.top: parent.top
        anchors.left: parent.left

        RowLayout {
            width: openCloseItem.width
            spacing: window.width / 30

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }

            // Set up Open Image button
            Button {
                // id: openImage
                text: "Open Image"

                onClicked: {
                    openFile.open()
                    // nameAndRes.imageName = guiOps.getFileName()
                }
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

        // Anchors
        anchors.left: parent.left
        anchors.top: parent.top

        width: (window.width - imageItem.width) / 2
        height: window.height

        // Margins
        anchors.leftMargin: width / 4
        anchors.topMargin: height / 15
        anchors.bottomMargin: height / 15

        Column {
            spacing: 5
            width: operationsItem1.width

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

        // Anchors
        anchors.right: parent.right
        anchors.top: parent.top

        width: (window.width - imageItem.width) / 2
        height: window.height

        // Margins
        anchors.rightMargin: width / 4
        anchors.topMargin: height / 15
        anchors.bottomMargin: height / 15


        Column {
            spacing: 2
            width: operationsItem2.width

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

                color: textColor
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

                color: textColor
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

                color: textColor
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

                property int rotateDegrees: 0

                width: rotate.height
                height: (rotate.width + rotate.height) / 2

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

                color: textColor
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

        width: window.width
        height: window.height

        RowLayout {
            width: window.width
            spacing: 20

            // Anchors
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            // Margins
            anchors.bottomMargin: window.height / 28

            // Fill the width of row
            Item {
                Layout.fillWidth: true
            }

            Column {
                spacing: 2

                Slider {
                    id: brightnessSlider

                    from: -100
                    value: 0
                    to: 100

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
                    color: textColor
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
                spacing: 2

                Slider {
                    id: contrastSlider

                    from: -100
                    value: 0
                    to: 100

                    snapMode: Slider.SnapAlways
                    stepSize: 5

                    property real contrastFactor: 0


                    onMoved: {
                        contrastSlider.contrastFactor = value
                    }
                }

                Text {
                    text: "Contrast Factor: <b>" + contrastSlider.contrastFactor + "</b>"

                    color: "black"
                    font.pointSize: 10
                    
                    anchors.horizontalCenter: parent.horizontalCenter

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
