//
//  IFSaturationFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFSaturationFilter.h"
#import "IFColorConversions.h"


@implementation IFSaturationFilter

@synthesize saturationAdjustment;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	for(int i=0; i < length; i+=4)
	{
		// Use the HSV color model, it works better with saturation than HSL
		IFColorRGB rgb = IFColorRGBMake(bytes[i+1], bytes[i+2], bytes[i+3]);
		IFColorHSV hsv = IFConvertRGBToHSV(rgb);
		
		hsv.s = MIN(MAX(0, hsv.s + saturationAdjustment), 255);
		
		rgb = IFConvertHSVToRGB(hsv);
		
		bytes[i+1] = rgb.r;
		bytes[i+2] = rgb.g;
		bytes[i+3] = rgb.b;
	}
}

@end
