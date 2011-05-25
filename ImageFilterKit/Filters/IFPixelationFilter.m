//
//  IFPixelationFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFPixelationFilter.h"


@implementation IFPixelationFilter

@synthesize pixelSize;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	if(pixelSize == 0) pixelSize = 10;
	
	for(int x = 0; x < width; x += pixelSize)
	{
		for(int y = 0; y < height; y += pixelSize)
		{
			int a = bytes[4 * (x + (y * width))];
			int r = bytes[4 * (x + (y * width)) + 1];
			int g = bytes[4 * (x + (y * width)) + 2];
			int b = bytes[4 * (x + (y * width)) + 3];
			
			for(int x2 = 0; x2 < pixelSize; x2++)
			{
				for(int y2 = 0; y2 < pixelSize; y2++)
				{
					int realX = x + x2;
					int realY = y + y2;
					if(realX < width && realY < height)
					{
						bytes[4 * (realX + (realY * width))] = a;
						bytes[4 * (realX + (realY * width)) + 1] = r;
						bytes[4 * (realX + (realY * width)) + 2] = g;
						bytes[4 * (realX + (realY * width)) + 3] = b;
					}
				}
			}
		}
	}
}

@end
