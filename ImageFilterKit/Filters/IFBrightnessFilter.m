//
//  IFBrightnessFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFBrightnessFilter.h"
#import "IFColorConversions.h"


@implementation IFBrightnessFilter

@synthesize brightnessAdjustment;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	for(int i=0; i < length; i+=4)
	{
		// HSL works better for lightness than HSV
		IFColorRGB rgb = IFColorRGBMake(bytes[i+1], bytes[i+2], bytes[i+3]);
		IFColorHSL hsl = IFConvertRGBToHSL(rgb);
		
		hsl.l = MIN(MAX(0, hsl.l + brightnessAdjustment), 255);
		
		rgb = IFConvertHSLToRGB(hsl);
		
		bytes[i+1] = rgb.r;
		bytes[i+2] = rgb.g;
		bytes[i+3] = rgb.b;
	}
}

@end
