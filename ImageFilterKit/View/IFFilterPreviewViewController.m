//
//  IFFilterPreviewViewController.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFFilterPreviewViewController.h"
#import "IFSimpleTintFilter.h"
#import "IFGreyscaleFilter.h"
#import "IFPixelationFilter.h"
#import "IFBrightnessFilter.h"
#import "IFThermalFilter.h"
#import "IFSnowFuzzFilter.h"


@implementation IFFilterPreviewViewController

@synthesize originalImage;

#pragma mark - Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	imageView.image = originalImage;
	
	// Add the nav bar button
	UIBarButtonItem *openFiltersButton = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStyleBordered target:self action:@selector(openFilterOptions)];
	self.navigationItem.rightBarButtonItem = openFiltersButton;
	[openFiltersButton release];
}

#pragma mark - Button Actions

- (void) openFilterOptions
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Tint Red", @"Greyscale", @"Pixelate", @"Brightness", @"Thermal", @"Snow Fuzz", nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (IBAction) sliderMoved:(id)sender
{
	UISlider *slider = (UISlider *)sender;
	
	IFPixelationFilter *pixels = [[IFPixelationFilter alloc] initWithOriginalImage:originalImage];
	pixels.pixelSize = roundf(slider.value);
	imageView.image = [pixels imageWithFilterApplied];
	[pixels release];
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		IFSimpleTintFilter *tinter = [[IFSimpleTintFilter alloc] initWithOriginalImage:originalImage];
		tinter.tintColor = [UIColor redColor];
		tinter.delegate = self;
		[tinter applyFilterOnNewThread];
		//imageView.image = [tinter imageWithFilterApplied];
		[tinter release];
	}
	else if(buttonIndex == 1)
	{
		IFGreyscaleFilter *grey = [[IFGreyscaleFilter alloc] initWithOriginalImage:originalImage];
		imageView.image = [grey imageWithFilterApplied];
		[grey release];
	}
	else if(buttonIndex == 2)
	{
		IFPixelationFilter *pixels = [[IFPixelationFilter alloc] initWithOriginalImage:originalImage];
		pixels.pixelSize = 5;
		imageView.image = [pixels imageWithFilterApplied];
		[pixels release];
	}
	else if(buttonIndex == 3)
	{
		IFBrightnessFilter *brightness = [[IFBrightnessFilter alloc] initWithOriginalImage:originalImage];
		brightness.brightnessAdjustment = 100;
		imageView.image = [brightness imageWithFilterApplied];
		[brightness release];
	}
	else if(buttonIndex == 4)
	{
		IFThermalFilter *thermal = [[IFThermalFilter alloc] initWithOriginalImage:originalImage];
		imageView.image = [thermal imageWithFilterApplied];
		[thermal release];
	}
	else if(buttonIndex == 5)
	{
		IFSnowFuzzFilter *acid = [[IFSnowFuzzFilter alloc] initWithOriginalImage:originalImage];
		imageView.image = [acid imageWithFilterApplied];
		[acid release];
	}
}

#pragma mark - Filter Delegate

- (void) filterDidApplyWithResult:(UIImage *)result
{
	imageView.image = result;
}

#pragma mark - Cleanup

- (void)dealloc
{
    [super dealloc];
	
	[originalImage release];
}

@end
