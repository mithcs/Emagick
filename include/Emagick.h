#ifndef EMAGICK_H
#define EMAGICK_H

#include <Magick++.h>

// Reads the image from imagePath parameter
// Returns 0 on success and 1 on failure
int readImage(std::string& imagePath, Magick::Image& image);

// Creates/Writes the image
// Returns 0 on success and 1 on failure
int writeImage(Magick::Image& image, std::string basename);

// Crops the image according to given geometry
// Returns 0 on success and 1 on failure
int cropImage(Magick::Image& image, int x, int y, int offsetx, int offsety);

// Grayscale the image
// Returns 0 on success and 1 on failure
int grayscaleImage(Magick::Image& image);

// Changes the gamma of image according to factor
// Returns 0 on success and 1 on failure
int changeGamma(Magick::Image& image, float factor);

// Rotate the image
// Returns 0 on success and 1 on failure
int rotateImage(Magick::Image& image, float degrees);

// Negate colors in the image
// Returns 0 on success and 1 on failure
int negateColors(Magick::Image& image);

// Normalize the image
// Returns 0 on success and 1 on failure
int normalizeImage(Magick::Image& image);

// Oil Paint the image based on radius
// Returns 0 on success and 1 on failure
int oilPaintImage(Magick::Image& image, int radius);

// Change the brightness of image according to factor(in %)
// Returns 0 on success and 1 on failure
int changeBrightness(Magick::Image& image, float factor);

#endif // !EMAGICK_H
