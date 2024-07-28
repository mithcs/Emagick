#ifndef EMAGICK_H
#define EMAGICK_H

#include <Magick++.h>

// -----------------------------------------------------------------------------
// TODO: Contrast

// Reads the image from imagePath parameter
// Returns true on success and false on failure
bool readImage(std::string& imagePath, Magick::Image& image);

// Creates/Writes the image
// Returns true on success and false on failure
bool writeImage(Magick::Image& image, std::string basename);

// -----------------------------------------------------------------------------
// ----------------------------------- 1 arg -----------------------------------
// -----------------------------------------------------------------------------

// Despeckle the image
//
// -- Reduce speckle noise
//
// Returns true on success and false on failure
bool despeckleImage(Magick::Image& image);

// Equalize the image
//
// -- Historgram equalization
//
// Returns true on success and false on failure
bool equalizeImage(Magick::Image& image);

// Erase the image
//
// -- Set all image pixels to the current background color
//
// Returns true on success and false on failure
bool eraseImage(Magick::Image& image);

// Flip the image
//
// -- Reflect each scanline in the vertical direction
//
// Returns true on success and false on failure
bool flipImage(Magick::Image& image);

// Flop the image
//
// -- Reflect each scanline in the horizontal direction
//
// Returns true on success and false on failure
bool flopImage(Magick::Image& image);

// Change the image color to grayscale
//
// Returns true on success and false on failure
bool grayscaleImage(Magick::Image& image);

// Magnify the image
//
// -- Magnify image by integral size
//
// Returns true on success and false on failure
bool magnifyImage(Magick::Image& image);

// Minify the image
//
// -- Magnify image by integral size
//
// Returns true on success and false on failure
bool minifyImage(Magick::Image& image);

// Negate colors in the image
//
// Returns true on success and false on failure
bool negateColors(Magick::Image& image);

// Normalize the image
//
// -- Increases contrast by normalizing the pixel values
// to span the full range of color values
//
// Returns true on success and false on failure
bool normalizeImage(Magick::Image& image);

// Trims the image edges
//
// -- Trim edges that are the background color from the image
//
// Returns true on success and false on failure
bool trimImage(Magick::Image& image);


// -----------------------------------------------------------------------------
// ---------------------------------- 2 args -----------------------------------
// -----------------------------------------------------------------------------

// Change the brightness of image according to factor(in %)
//
// -- Uses modulate under-the-hood -> modulate(brightness, saturation, hue), where 100% is default
//
// Returns true on success and false on failure
bool changeBrightness(Magick::Image& image, float factor);

// Gamma correct image
//
// -- Changes the gamma of image according to factor
//
// Returns true on success and false on failure
bool changeGamma(Magick::Image& image, float factor);

// Oil paint the image based on radius
//
// -- Make image look like oil painting
//
// Returns true on success and false on failure
bool oilPaintImage(Magick::Image& image, int radius);

// Rotate the image
//
// -- Rotate image counter-clockwise by specified number of degrees
//
// Returns true on success and false on failure
bool rotateImage(Magick::Image& image, float degrees);

// Add noise to the image
//
// -- Add noise to image with specified noise type
//
// Returns true on success and false on failure
bool addNoise(Magick::Image& image, MagickCore::NoiseType noiseType);

// Threshold image
//
// -- Partition image fg and bg
//
// Returns true on success and false on failure
bool thresholdImage(Magick::Image& image, float threshold);

// Edge image
//
// -- Highlightes edges in image
// -- Radius is the radius of pixel neightborhood. 0 -> auto selection
//
// Returns true on success and false on failure
bool edgeImage(Magick::Image& image, float radius);

// Reduce Noise
//
// -- Reduce noise in image using peak noise elimination filter
//
// Returns true on success and false on failure
bool reduceNoise(Magick::Image& image, float order);

// -----------------------------------------------------------------------------
// ---------------------------------- 3 args -----------------------------------
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// ---------------------------------- 3+ args ----------------------------------
// -----------------------------------------------------------------------------

// Crops the image according to given geometry
//
// -- Crop subregion of original image
//
// Returns true on success and false on failure
bool cropImage(Magick::Image& image, int x, int y, int offsetx, int offsety);


// -----------------------------------------------------------------------------

#endif // !EMAGICK_H
