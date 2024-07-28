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
        // The values are actually in '%' (100 for no change)
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

bool eraseImage(Magick::Image& image) {
    try {
        // Erase the image
        image.erase();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to erase image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool flipImage(Magick::Image& image) {
    try {
        // Flip the image
        image.flip();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to flip image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool flopImage(Magick::Image& image) {
    try {
        // Flop the image
        image.flop();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to flop image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool magnifyImage(Magick::Image& image) {
    try {
        // Magnify the image
        image.magnify();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to magnify image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool minifyImage(Magick::Image& image) {
    try {
        // Minify the image
        image.minify();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to minify image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool trimImage(Magick::Image& image) {
    try {
        // Trim the image
        image.trim();
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to trim edges: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool addNoise(Magick::Image& image, MagickCore::NoiseType NoiseType) {
    try {
        // Add the noise
        image.addNoise(NoiseType);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to add noise to image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool thresholdImage(Magick::Image& image, float threshold) {
    try {
        // Threshold image
        image.threshold(threshold);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to threshold image: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool edgeImage(Magick::Image& image, float radius) {
    try {
        // Edge image
        image.edge(radius);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to highlight edges: " << error_.what() << std::endl;
        return false;
    }

    return true;
}

bool reduceNoise(Magick::Image& image, float order) {
    try {
        // Reduce noise
        image.reduceNoise(order);
    }
    catch (Magick::Exception &error_) {
        std::cout << "Unable to reduce noise: " << error_.what() << std::endl;
        return false;
    }

    return true;
}
