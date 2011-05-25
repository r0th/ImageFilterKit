//
//  UIImage+RawData.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/7/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (RawData)

+ (UIImage *) imageWithRawImageData:(NSData *)data width:(int)width height:(int)height;
- (NSData *) rawImageData;

@end
