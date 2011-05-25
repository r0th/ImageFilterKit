//
//  IFFilter.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import "IFFilter.h"
#import "UIImage+RawData.h"
#import "IFFilterOperation.h"


@implementation IFFilter

@synthesize originalImage, delegate;

#pragma mark - Initialization

- (id) initWithOriginalImage:(UIImage *)image
{
	self = [super init];
	if(self)
	{
		self.originalImage = image;
		operationQueue = [[NSOperationQueue alloc] init];
	}
	
	return self;
}

#pragma mark - Image Processing

- (UIImage *) imageWithFilterApplied
{
	NSData *rawData = [originalImage rawImageData];
	[self manipulateRawBytes:(UInt8 *)[rawData bytes] length:[rawData length] width:self.originalImage.size.width height:self.originalImage.size.height];
	UIImage *processedImage = [UIImage imageWithRawImageData:rawData width:self.originalImage.size.width height:self.originalImage.size.height];
	UIImage *postProcessedImage = [self imageWithPostProcessedFilter:processedImage];
	
	return postProcessedImage;
}

- (void) applyFilterOnNewThread
{
	IFFilterOperation *operation = [[IFFilterOperation alloc] init];
	operation.delegate = delegate;
	operation.filter = self;
	
	[operationQueue addOperation:operation];
	[operation release];
}

- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height
{
	// Do nothing in base implementation
}

- (UIImage *) imageWithPostProcessedFilter:(UIImage *)processedImage
{
	return processedImage;
}

#pragma mark - Cleanup

- (void) dealloc
{
	delegate = nil;
	[operationQueue release];
	[originalImage release];
	[super dealloc];
}

@end
