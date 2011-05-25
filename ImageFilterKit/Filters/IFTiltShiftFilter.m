//
//  IFTiltShiftFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 4/6/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFTiltShiftFilter.h"
#import "IFColorConversions.h"


@implementation IFTiltShiftFilter

#define largeBlurSize 7

double largeBlur[largeBlurSize][largeBlurSize] =
{
    0, 0, 0, 2, 0, 0, 0,
    0, 0, 2, 4, 2, 0, 0,
    0, 2, 4, 6, 4, 2, 0,
    2, 4, 6, 8, 6, 3, 2,
    0, 2, 4, 6, 4, 2, 0,
	0, 0, 2, 4, 2, 0, 0,
	0, 0, 0, 2, 0, 0, 0,
};

double largeBlurFactor = 1.0 / 88.0; // The number of 1s in the matrix to make them all add up to 1.
double largeBlurBias = 0.0;

#define mediumBlurSize 5

double mediumBlur[mediumBlurSize][mediumBlurSize] =
{
    0, 0, 2, 0, 0,
    0, 2, 4, 2, 0,
    2, 4, 6, 4, 2,
    0, 2, 4, 2, 0,
    0, 0, 2, 0, 0,
};

double mediumBlurFactor = 1.0 / 38.0; // The number of 1s in the matrix to make them all add up to 1.
double mediumBlurBias = 0.0;

#define smallBlurSize 3

double smallBlur[smallBlurSize][smallBlurSize] =
{
    0, 1, 0,
    1, 2, 1,
    0, 1, 0,
};

double smallBlurFactor = 1.0 / 6.0; // The number of 1s in the matrix to make them all add up to 1.
double smallBlurBias = 0.0;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	static IFColorRGB image[2000][2000]; 
	static IFColorRGB result[2000][2000];
	
	if(width > 2000) width = 2000;
	if(height > 2000) height = 2000;
	
	// Set the RGB values for the image matrix
	for(int x = 0; x < width; x++)
	{
		for(int y = 0; y < height; y++)
		{
			int r = bytes[4 * (x + (y * width)) + 1];
			int g = bytes[4 * (x + (y * width)) + 2];
			int b = bytes[4 * (x + (y * width)) + 3];
			
			image[x][y] = IFColorRGBMake(r, g, b);
			result[x][y] = IFColorRGBMake(0, 0, 0);
		}
	}
	
	// Apply the blur filter
    for(int x = 0; x < width; x++)
	{
		for(int y = 0; y < height; y++) 
		{ 
			double red = 0.0, green = 0.0, blue = 0.0;
			
			// Check which sized filter to use
			if((x < (width/7) || x > (width - (width/7))) || (y < (height/7) || y > (height - (height/7))))
			{
				// Use the largest blur
				
				// Multiply every value of the filter with corresponding image pixel 
				for(int filterX = 0; filterX < largeBlurSize; filterX++)
				{
					for(int filterY = 0; filterY < largeBlurSize; filterY++)
					{ 
						int imageX = (x - largeBlurSize / 2 + filterX + width) % width;
						int imageY = (y - largeBlurSize / 2 + filterY + height) % height;
						
						red += image[imageX][imageY].r * largeBlur[filterX][filterY];
						green += image[imageX][imageY].g * largeBlur[filterX][filterY];
						blue += image[imageX][imageY].b * largeBlur[filterX][filterY];
					}
				}
				
				// Truncate values smaller than zero and larger than 255 
				result[x][y].r = MIN(MAX(round(largeBlurFactor * red + largeBlurBias), 0), 255); 
				result[x][y].g = MIN(MAX(round(largeBlurFactor * green + largeBlurBias), 0), 255); 
				result[x][y].b = MIN(MAX(round(largeBlurFactor * blue + largeBlurBias), 0), 255);
			}
			else if((x < (width/7)*2 || x > (width - (width/7)*2)) || (y < (height/7)*2 || y > (height - (height/7)*2)))
			{
				// Use the medium blur
				
				// Multiply every value of the filter with corresponding image pixel 
				for(int filterX = 0; filterX < mediumBlurSize; filterX++)
				{
					for(int filterY = 0; filterY < mediumBlurSize; filterY++)
					{ 
						int imageX = (x - mediumBlurSize / 2 + filterX + width) % width;
						int imageY = (y - mediumBlurSize / 2 + filterY + height) % height;
						
						red += image[imageX][imageY].r * mediumBlur[filterX][filterY];
						green += image[imageX][imageY].g * mediumBlur[filterX][filterY];
						blue += image[imageX][imageY].b * mediumBlur[filterX][filterY];
					}
				}
				
				// Truncate values smaller than zero and larger than 255 
				result[x][y].r = MIN(MAX(round(mediumBlurFactor * red + mediumBlurBias), 0), 255); 
				result[x][y].g = MIN(MAX(round(mediumBlurFactor * green + mediumBlurBias), 0), 255); 
				result[x][y].b = MIN(MAX(round(mediumBlurFactor * blue + mediumBlurBias), 0), 255);
			}
			else if((x < (width/7)*3 || x > (width - (width/7)*3)) || (y < (height/7)*3 || y > (height - (height/7)*3)))
			{
				// Use the small blur
				
				// Multiply every value of the filter with corresponding image pixel 
				for(int filterX = 0; filterX < smallBlurSize; filterX++)
				{
					for(int filterY = 0; filterY < smallBlurSize; filterY++)
					{ 
						int imageX = (x - smallBlurSize / 2 + filterX + width) % width;
						int imageY = (y - smallBlurSize / 2 + filterY + height) % height;
						
						red += image[imageX][imageY].r * smallBlur[filterX][filterY];
						green += image[imageX][imageY].g * smallBlur[filterX][filterY];
						blue += image[imageX][imageY].b * smallBlur[filterX][filterY];
					}
				}
				
				// Truncate values smaller than zero and larger than 255 
				result[x][y].r = MIN(MAX(round(smallBlurFactor * red + smallBlurBias), 0), 255); 
				result[x][y].g = MIN(MAX(round(smallBlurFactor * green + smallBlurBias), 0), 255); 
				result[x][y].b = MIN(MAX(round(smallBlurFactor * blue + smallBlurBias), 0), 255);
			}
			else
			{
				// Identity
				result[x][y].r = image[x][y].r; 
				result[x][y].g = image[x][y].g; 
				result[x][y].b = image[x][y].b; 
			}
		}
	}
	
	for(int x = 0; x < width; x++)
	{
		for(int y = 0; y < height; y++) 
		{
			bytes[4 * (x + (y * width)) + 1] = result[x][y].r;
			bytes[4 * (x + (y * width)) + 2] = result[x][y].g;
			bytes[4 * (x + (y * width)) + 3] = result[x][y].b;
		}
	}
}

@end
