//
//  IFHueFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/30/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFHueFilter.h"
#import "IFColorConversions.h"


@implementation IFHueFilter

@synthesize hueAdjustment;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{	
	for(int i=0; i < length; i+=4)
	{
		IFColorRGB rgb = IFColorRGBMake(bytes[i+1], bytes[i+2], bytes[i+3]);
		IFColorHSL hsl = IFConvertRGBToHSL(rgb);
		
		hsl.h = hsl.h + hueAdjustment;
		
		if(hsl.h > 360) hsl.h = hsl.h - 360;
		if(hsl.h < 0) hsl.h = hsl.h + 360;
		
		rgb = IFConvertHSLToRGB(hsl);
		
		bytes[i+1] = rgb.r;
		bytes[i+2] = rgb.g;
		bytes[i+3] = rgb.b;
	}
}

@end
