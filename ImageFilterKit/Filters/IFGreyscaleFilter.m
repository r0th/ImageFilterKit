//
//  IFGreyscaleFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFGreyscaleFilter.h"


@implementation IFGreyscaleFilter

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	 for(int i=0; i < length; i+=4)
	 {
		 int averageColor = round((bytes[i+1] + bytes[i+2] + bytes[i+3]) / 3);
		 bytes[i+1] = averageColor;
		 bytes[i+2] = averageColor;
		 bytes[i+3] = averageColor;
	 }
}

@end
