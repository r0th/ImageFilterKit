//
//  IFSharpenFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/30/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFSharpenFilter.h"
#import "IFColorConversions.h"


@implementation IFSharpenFilter

#define filterWidth 3
#define filterHeight 3

double sharpenFilter[filterWidth][filterHeight] =
{
    -1, -1, -1,
    -1,  9, -1,
    -1, -1, -1
};

double sharpenFactor = 1.0;
double sharpenBias = 0.0;

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
			
			// Multiply every value of the filter with corresponding image pixel 
			for(int filterX = 0; filterX < filterWidth; filterX++)
			{
				for(int filterY = 0; filterY < filterHeight; filterY++)
				{ 
					int imageX = (x - filterWidth / 2 + filterX + width) % width;
					int imageY = (y - filterHeight / 2 + filterY + height) % height;
					
					red += image[imageX][imageY].r * sharpenFilter[filterX][filterY];
					green += image[imageX][imageY].g * sharpenFilter[filterX][filterY];
					blue += image[imageX][imageY].b * sharpenFilter[filterX][filterY];
				}
			}
			
			// Truncate values smaller than zero and larger than 255 
			result[x][y].r = MIN(MAX(round(sharpenFactor * red + sharpenBias), 0), 255); 
			result[x][y].g = MIN(MAX(round(sharpenFactor * green + sharpenBias), 0), 255); 
			result[x][y].b = MIN(MAX(round(sharpenFactor * blue + sharpenBias), 0), 255);
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
