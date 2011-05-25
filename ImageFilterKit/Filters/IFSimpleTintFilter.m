//
//  IFSimpleTintFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFSimpleTintFilter.h"


@implementation IFSimpleTintFilter

@synthesize tintColor;

- (UIImage *) imageWithPostProcessedFilter:(UIImage *)processedImage
{
	if(!tintColor) return processedImage;
	
	// Construct new image the same size as this one.
	UIImage *image;
	UIGraphicsBeginImageContextWithOptions(processedImage.size, NO, 0.0);
	CGRect rect = CGRectZero;
	rect.size = processedImage.size;
	
	// Tint the image
	[processedImage drawInRect:rect];
	[tintColor set];
	UIRectFillUsingBlendMode(rect, kCGBlendModeColor);
	
	// Restore alpha channel
	[processedImage drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
	
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

- (void) dealloc
{
	[tintColor release];
	[super dealloc];
}

@end
