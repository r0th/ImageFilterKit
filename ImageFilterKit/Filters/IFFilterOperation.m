//
//  IFFilterOperation.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFFilterOperation.h"


@implementation IFFilterOperation

@synthesize filter, delegate;

- (void)main
{
	UIImage *image = [filter imageWithFilterApplied];
	[delegate performSelectorOnMainThread:@selector(filterDidApplyWithResult:) withObject:image waitUntilDone:NO];
}

- (void) dealloc
{
	delegate = nil;
	[filter release];
	[super dealloc];
}

@end
