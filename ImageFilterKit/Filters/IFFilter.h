//
//  IFFilter.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IFFilterDelegate <NSObject>

- (void) filterDidApplyWithResult:(UIImage *)result;

@end

@interface IFFilter : NSObject
{
    UIImage *originalImage;
	id <IFFilterDelegate> delegate;
	NSOperationQueue *operationQueue;
}

@property (nonatomic, retain) UIImage *originalImage;
@property (nonatomic, assign) id <IFFilterDelegate> delegate;

- (id) initWithOriginalImage:(UIImage *)image;

// Main methods
- (UIImage *) imageWithFilterApplied;
- (void) applyFilterOnNewThread;

// Override these methods in filter implementations
- (void) manipulateRawBytes:(UInt8 *)bytes length:(int)length width:(int)width height:(int)height;
- (UIImage *) imageWithPostProcessedFilter:(UIImage *)processedImage;

@end
