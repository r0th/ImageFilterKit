//
//  IFThermalFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFThermalFilter.h"


@implementation IFThermalFilter

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	for(int i=0; i < length; i+=4)
	{
		int totalBrightness = bytes[i+1] + bytes[i+2] + bytes[i+3];
		int averageBrightness = round(totalBrightness / 3);
		
		if(averageBrightness > 127)
		{
			bytes[i+1] = MIN(255, MAX(0, bytes[i+1] + (averageBrightness-127)));
			bytes[i+2] = (averageBrightness - 127);
			bytes[i+3] = 0;
		}
		else
		{
			bytes[i+1] = 0;
			bytes[i+2] = averageBrightness;
			bytes[i+3] = MIN(255, MAX(0, bytes[i+3] + (127-averageBrightness)));
		}	
	}
}

@end
