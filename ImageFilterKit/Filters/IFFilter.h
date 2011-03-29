//
//  IFFilter.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFFilter : NSObject
{
    UIImage *originalImage;
}

@property (nonatomic, retain) UIImage *originalImage;

- (id) initWithOriginalImage:(UIImage *)image;

// Main method
- (UIImage *) imageWithFilterApplied;

// Override these methods in filter implementations
- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height;
- (UIImage *) imageWithPostProcessedFilter:(UIImage *)processedImage;

@end
