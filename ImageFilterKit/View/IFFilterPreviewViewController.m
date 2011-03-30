//
//  IFFilterPreviewViewController.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFFilterPreviewViewController.h"
#import "ImageFilterKitAppDelegate.h"
#import "IFSimpleTintFilter.h"
#import "IFGreyscaleFilter.h"
#import "IFPixelationFilter.h"
#import "IFBrightnessFilter.h"
#import "IFThermalFilter.h"
#import "IFSnowFuzzFilter.h"
#import "IFSaturationFilter.h"
#import "IFHueFilter.h"


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
	
	slider.hidden = YES;
}

#pragma mark - Button Actions

- (void) openFilterOptions
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Tint Red", @"Greyscale", @"Pixelate", @"Brightness", @"Saturation", @"Hue", @"Thermal", @"Snow Fuzz", nil];
	[actionSheet showInView:((ImageFilterKitAppDelegate *)[UIApplication sharedApplication].delegate).window];
	[actionSheet release];
}

- (IBAction) sliderMoved:(id)sender
{
	if(sliderMode == IFFilterPreviewSliderModePixelate)
	{
		IFPixelationFilter *pixels = [[IFPixelationFilter alloc] initWithOriginalImage:originalImage];
		pixels.pixelSize = roundf(slider.value);
		imageView.image = [pixels imageWithFilterApplied];
		[pixels release];
	}
	else if(sliderMode == IFFilterPreviewSliderModeBrightness)
	{
		IFBrightnessFilter *brightness = [[IFBrightnessFilter alloc] initWithOriginalImage:originalImage];
		brightness.brightnessAdjustment = roundf(slider.value);
		imageView.image = [brightness imageWithFilterApplied];
		[brightness release];
	}
	else if(sliderMode == IFFilterPreviewSliderModeSaturation)
	{
		IFSaturationFilter *saturation = [[IFSaturationFilter alloc] initWithOriginalImage:originalImage];
		saturation.saturationAdjustment = roundf(slider.value);
		imageView.image = [saturation imageWithFilterApplied];
		[saturation release];
	}
	
	else if(sliderMode == IFFilterPreviewSliderModeHue)
	{
		IFHueFilter *hue = [[IFHueFilter alloc] initWithOriginalImage:originalImage];
		hue.hueAdjustment = roundf(slider.value);
		imageView.image = [hue imageWithFilterApplied];
		[hue release];
	}
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	slider.hidden = YES;
	
	if(buttonIndex == 0)
	{
		IFSimpleTintFilter *tinter = [[IFSimpleTintFilter alloc] initWithOriginalImage:originalImage];
		tinter.tintColor = [UIColor redColor];
		imageView.image = [tinter imageWithFilterApplied];
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
		slider.minimumValue = 1.0;
		slider.maximumValue = 20.0;
		slider.value = 1.0;
		sliderMode = IFFilterPreviewSliderModePixelate;
		slider.hidden = NO;
		[self sliderMoved:slider];
	}
	else if(buttonIndex == 3)
	{
		slider.minimumValue = -150.0;
		slider.maximumValue = 150.0;
		slider.value = 0.0;
		sliderMode = IFFilterPreviewSliderModeBrightness;
		slider.hidden = NO;
		[self sliderMoved:slider];
	}
	else if(buttonIndex == 4)
	{
		slider.minimumValue = -150.0;
		slider.maximumValue = 150.0;
		slider.value = 0.0;
		sliderMode = IFFilterPreviewSliderModeSaturation;
		slider.hidden = NO;
		[self sliderMoved:slider];
	}
	else if(buttonIndex == 5)
	{
		slider.minimumValue = 0;
		slider.maximumValue = 360.0;
		slider.value = 0.0;
		sliderMode = IFFilterPreviewSliderModeHue;
		slider.hidden = NO;
	}
	else if(buttonIndex == 6)
	{
		IFThermalFilter *thermal = [[IFThermalFilter alloc] initWithOriginalImage:originalImage];
		imageView.image = [thermal imageWithFilterApplied];
		[thermal release];
	}
	else if(buttonIndex == 7)
	{
		IFSnowFuzzFilter *snow = [[IFSnowFuzzFilter alloc] initWithOriginalImage:originalImage];
		imageView.image = [snow imageWithFilterApplied];
		[snow release];
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
