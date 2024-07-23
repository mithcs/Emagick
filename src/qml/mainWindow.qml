import QtQuick
import QtQuick.Controls

// Window type for simple GUI
Window {
    // Make it visible
    visible: true

    // Set up geometry
    width: 800
    height: 800

    // Set id
    id: mainWindow

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
}
