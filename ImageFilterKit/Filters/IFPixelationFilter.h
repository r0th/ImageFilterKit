//
//  IFPixelationFilter.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFFilter.h"


@interface IFPixelationFilter : IFFilter
{
    int pixelSize;
}

@property (nonatomic) int pixelSize;

@end
