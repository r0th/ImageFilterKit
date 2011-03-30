//
//  IFHueFilter.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/30/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFFilter.h"


@interface IFHueFilter : IFFilter
{
    int hueAdjustment;
}

@property (nonatomic) int hueAdjustment; // The amount to adjust in degrees.

@end
