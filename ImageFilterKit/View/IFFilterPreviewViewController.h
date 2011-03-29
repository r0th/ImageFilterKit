//
//  IFFilterPreviewViewController.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFFilter.h"


@interface IFFilterPreviewViewController : UIViewController <UIActionSheetDelegate, IFFilterDelegate>
{
    UIImage *originalImage;
	
	IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) UIImage *originalImage;

- (void) openFilterOptions;
- (IBAction) sliderMoved:(id)sender;

@end
