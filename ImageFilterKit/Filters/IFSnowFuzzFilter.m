//
//  IFAcidFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFSnowFuzzFilter.h"


@implementation IFSnowFuzzFilter

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	for(int i=0; i < length; i+=4)
	{
		float sine = sin(i);
		
		bytes[i+1] = MAX(0, MIN(255, bytes[i+1] + round(255 * sin(bytes[i+1]) * sine)));
		bytes[i+2] = MAX(0, MIN(255, bytes[i+2] + round(255 * sin(bytes[i+1]) * sine)));
		bytes[i+3] = MAX(0, MIN(255, bytes[i+3] + round(255 * sin(bytes[i+1]) * sine)));
	}
}

@end
