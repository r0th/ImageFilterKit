//
//  IFSaturationFilter.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFFilter.h"


@interface IFSaturationFilter : IFFilter
{
    int saturationAdjustment;
}

@property (nonatomic) int saturationAdjustment; // Amount to adjust saturation. Negative values decrease saturation.

@end
