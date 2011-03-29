//
//  IFSaturationFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFSaturationFilter.h"


@implementation IFSaturationFilter

@synthesize saturationAdjustment;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	int r, g, b;
	for(int i=0; i < length; i+=4)
	{
		r = bytes[i+1];
		g = bytes[i+2];
		b = bytes[i+3];
		
		if(r > g && r > b)
		{
			bytes[i+1] = MIN(MAX(0, bytes[i+1] + saturationAdjustment), 255);
		}
		else if(g > r && g > b)
		{
			bytes[i+2] = MIN(MAX(0, bytes[i+2] + saturationAdjustment), 255);
		}
		else if(b > r && b > g)
		{
			bytes[i+3] = MIN(MAX(0, bytes[i+3] + saturationAdjustment), 255);
		}
	}
}

@end
