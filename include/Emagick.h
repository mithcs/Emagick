#ifndef EMAGICK_H
#define EMAGICK_H

#include <Magick++.h>

// Reads the image from imagePath parameter
// Returns true on success and false on failure
bool readImage(std::string& imagePath, Magick::Image& image);

// Creates/Writes the image
// Returns true on success and false on failure
bool writeImage(Magick::Image& image, std::string basename);

// Crops the image according to given geometry
// Returns true on success and false on failure
bool cropImage(Magick::Image& image, int x, int y, int offsetx, int offsety);

// Grayscale the image
// Returns true on success and false on failure
bool grayscaleImage(Magick::Image& image);

// Changes the gamma of image according to factor
// Returns true on success and false on failure
bool changeGamma(Magick::Image& image, float factor);

// Rotate the image
// Returns true on success and false on failure
bool rotateImage(Magick::Image& image, float degrees);

// Negate colors in the image
// Returns true on success and false on failure
bool negateColors(Magick::Image& image);

// Normalize the image
// Returns true on success and false on failure
bool normalizeImage(Magick::Image& image);

// Oil Pabool the image based on radius
// Returns true on success and false on failure
bool oilPaintImage(Magick::Image& image, int radius);

// Change the brightness of image according to factor(in %)
// Returns true on success and false on failure
bool changeBrightness(Magick::Image& image, float factor);

#endif // !EMAGICK_H
