//
//  IFFilterPreviewViewController.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFFilterPreviewViewController.h"


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
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Tint Red", nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
			
			break;
			
		default:
			break;
	}
}

#pragma mark - Cleanup

- (void)dealloc
{
    [super dealloc];
	
	[originalImage release];
}

@end
