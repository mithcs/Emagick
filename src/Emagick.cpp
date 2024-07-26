#include "Emagick.h"
#include "utility.h"

bool readImage(std::string& imagePath, Magick::Image& image) {
    try {
        // Read file from imagePath to Image object.
        image.read(imagePath);
    }
    catch(Magick::Exception &error_) {
        std::cout << "Unable to read image: " << error_.what() << std::endl;
        return false;
    }
    return true;
}

bool writeImage(Magick::Image& image, std::string baseName) {
    // filename = baseName + . + extension
    std::string filename = baseName + "." + toLowercase(image.magick());

    try {
        // Save the modified image
        image.write(filename);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to write image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool cropImage(Magick::Image& image, int x, int y, int offsetx, int offsety) {
    try {
        // Crop the image according the given geometry
        image.crop(Magick::Geometry(x, y, offsetx, offsety));
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to crop image: " << error_.what() << std::endl;
        return false;
    }
    
    return true;
}

bool grayscaleImage(Magick::Image& image) {
    try {
        // Grayscale the image
        image.type(Magick::GrayscaleType);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to grayscale image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool changeGamma(Magick::Image& image, float factor) {
    try {
        // Change gamma of the image
        image.gamma(factor);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to change gamma of the image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool rotateImage(Magick::Image& image, float degrees) {
    try {
        // Rotate the image degrees
        image.rotate(degrees);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to rotate image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool negateColors(Magick::Image& image) {
    try {
        // Negate colors of the image

        // Set grayscale to only negate greyscale values in image (default: false)
        image.negate(false);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to negate colors: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool normalizeImage(Magick::Image& image) {
    try {
        // Normalize the image
        image.normalize();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to normalize image: " << error_.what() << std::endl;
        return false;
    }
    return true;
}

bool oilPaintImage(Magick::Image& image, int radius) {
    try {
        // Oil Paint the image
        image.oilPaint(radius);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to oil paint image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool changeBrightness(Magick::Image& image, float factor) {
    try {
        // Change the brightness of image
        // The values are actually '%' (100 for no change)
        image.modulate(factor, 100.0, 100.0);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to change brightness of the image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool despeckleImage(Magick::Image& image) {
    try {
        // Despeckle the image
        image.despeckle();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to despeckle image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool equalizeImage(Magick::Image& image) {
    try {
        // Equalize the image
        image.equalize();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to equalize image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}
