//
//  UIImage+RawData.m
//  MaskingPrototype
//
//  Created by Andy Roth on 3/7/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "UIImage+RawData.h"


@implementation UIImage (RawData)

+ (UIImage *) imageWithRawImageData:(NSData *)data width:(int)width height:(int)height
{	
	CFDataRef imageData = (CFDataRef)data;
	CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData(imageData);
	
	size_t bitsPerComponent = 8;
	size_t bitsPerPixel = 32;
	size_t bytesPerPixel = bitsPerPixel / 8; // 4
	size_t bytesPerRow = width * bytesPerPixel;
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo info = kCGImageAlphaPremultipliedFirst;
	CGColorRenderingIntent intent = kCGRenderingIntentDefault;
	
	// Create the new CGImageRef
	CGImageRef throughCGImage = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, info, imgDataProvider, NULL, NO, intent);
	CGDataProviderRelease(imgDataProvider);
	
	// make UIImage with CGImage
	UIImage *resultImage = [[UIImage alloc] initWithCGImage:throughCGImage];
	
	CGImageRelease(throughCGImage);
	
	return [resultImage autorelease];
}

- (NSData *) rawImageData
{
	// Use ARGB ColorSpace
	size_t bytesPerPixel = 4;
	size_t bitsPerComponent = 8;
	
	CGImageAlphaInfo alphaInfo = kCGImageAlphaPremultipliedFirst;
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	int width = self.size.width;  
	int height = self.size.height;
	
	// Allocate memory for our bitmap context based on above sizes
	UInt8* pixelData = malloc( width * height * bytesPerPixel );
	
	// Create the bitmap context
	CGContextRef context = CGBitmapContextCreate (pixelData, width, height, bitsPerComponent, width * bytesPerPixel, colorSpace, alphaInfo);
	
	if( !context )  
	{
		return nil;
	}
	
	// Render the image into the context (ending up in our buffer)
	CGContextDrawImage( context, CGRectMake(0, 0, width, height), self.CGImage );
	CGContextRelease( context );
	
	NSData *rawData = [NSData dataWithBytes:pixelData length:(width * height * bytesPerPixel)];
	
	return rawData;
}

@end
