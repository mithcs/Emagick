#include <Magick++.h>
#include <iostream>

#include "Emagick.h"

using namespace std;

int main(int argc, char **argv) {
    // Initialize Magick
    Magick::InitializeMagick(*argv);

    // Set argument as imagePath
    string imagePath = argv[1];

    // Construct the image object
    Magick::Image image;

    // Read image for further processing
    if (readImage(imagePath, image) != 0) {
        cout << "Exiting..." << endl;
        return 1;
    }

    // Variables for {x,y} dimensions and {x-offset, y-offset}
    int x = 100, y = 200;
    int offsetx = 0, offsety = 0;

    // Crop given image 
    if (cropImage(image, x, y, offsetx, offsety) != 0) {
        cout << "Exiting..." << endl;
        return 1;
    }

    // Basename of image to write
    string baseName = "output";

    // Write image
    if (writeImage(image, baseName) != 0) {
        cout << "Exiting..." << endl;
        return 1;
    }

    cout << "Operation Completed." << endl;

    return 0;
}
