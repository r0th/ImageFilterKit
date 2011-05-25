//
//  IFBrightnessFilter.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFFilter.h"

@interface IFBrightnessFilter : IFFilter
{
    int brightnessAdjustment;
}

@property (nonatomic) int brightnessAdjustment; // Amount to adjust brightness. Negative values decrease brightness.

@end
