//
//  ImageFilterKitAppDelegate.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFPhotoSelectionViewController.h"

@interface ImageFilterKitAppDelegate : NSObject <UIApplicationDelegate>
{
	UINavigationController *navigationController;
	IFPhotoSelectionViewController *photoSelectionViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
