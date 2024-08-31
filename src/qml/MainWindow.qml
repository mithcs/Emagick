import QtCore                       // For StandardPaths
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts

Window {
    id: window

    visible: true

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

        anchors.centerIn: parent
        // anchors.verticalCenterOffset: -45

        // Column for Image
        Column {
            id: imageCol

            width: parent.width
            height: parent.height

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

            Item {
                Layout.fillWidth: true
            }

            Button {
                id: openImage
                text: "Open Image"

                onClicked: {
                    openFile.open()
                    // nameAndRes.imageName = guiOps.getFileName()
                }
            }

            Button {
                id: saveImage
                text: "Save Image"

                onClicked: saveFile.open()
            }

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

        anchors.left: parent.left
        anchors.top: parent.top

        width: (window.width - imageItem.width) / 2
        height: window.height

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

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: grayscale
                text: "Grayscale Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyGrayscale()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: negate
                text: "Negate Colors"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyNegation()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: despeckle
                text: "Despeckle Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyDespeckle()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: equalize
                text: "Equalize Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyEqualization()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: erase
                text: "Erase Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyErasure()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: flip
                text: "Flip Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyFlip()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: flop
                text: "Flop Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyFlop()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: magnify
                text: "Magnify Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyMagnification()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: minify
                text: "Minify Image"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyMinification()

                    mainImage.source = guiOps.updatedImage()
                }
            }

            Button {
                id: trim
                text: "Trim Edges"

                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {
                    guiOps.applyTrim()

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

                    mainImage.source = guiOps.updatedImage()
                }
            }

        }
    }

    // Container for right side operational buttons & stuff:
    Item {
        id: operationsItem2

        anchors.right: parent.right
        anchors.top: parent.top

        width: (window.width - imageItem.width) / 2
        height: window.height

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

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            anchors.bottomMargin: window.height / 28

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
