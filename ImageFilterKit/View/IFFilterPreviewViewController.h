//
//  IFFilterPreviewViewController.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFFilter.h"

enum
{
	IFFilterPreviewSliderModePixelate = 0,
	IFFilterPreviewSliderModeBrightness = 1,
	IFFilterPreviewSliderModeSaturation = 2,
	IFFilterPreviewSliderModeHue = 3
} IFFilterPreviewSliderMode;

@interface IFFilterPreviewViewController : UIViewController <UIActionSheetDelegate, IFFilterDelegate>
{
    UIImage *originalImage;
	
	IBOutlet UISlider *slider;
	IBOutlet UIImageView *imageView;
	IBOutlet UIView *activityView;
	
	int sliderMode;
}

@property (nonatomic, retain) UIImage *originalImage;

- (void) openFilterOptions;
- (IBAction) sliderMoved:(id)sender;

@end
