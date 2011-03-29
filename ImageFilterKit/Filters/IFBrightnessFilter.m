//
//  IFBrightnessFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFBrightnessFilter.h"


@implementation IFBrightnessFilter

@synthesize brightnessAdjustment;

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	for(int i=0; i < length; i+=4)
	{
		bytes[i+1] = MIN(MAX(0, bytes[i+1] + brightnessAdjustment), 255);
		bytes[i+2] = MIN(MAX(0, bytes[i+2] + brightnessAdjustment), 255);
		bytes[i+3] = MIN(MAX(0, bytes[i+3] + brightnessAdjustment), 255);
	}
}

@end
