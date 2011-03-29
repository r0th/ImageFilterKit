//
//  IFPhotoSelectionViewController.m
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Resource Interactive. All rights reserved.
//

#import "IFPhotoSelectionViewController.h"
#import "IFFilterPreviewViewController.h"


@implementation IFPhotoSelectionViewController

#pragma mark - Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	imagePicker.allowsEditing = YES;
}

#pragma mark - Button Actions

- (IBAction) openCamera
{
	imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self presentModalViewController:imagePicker animated:YES];
}

- (IBAction) openLibrary
{
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentModalViewController:imagePicker animated:YES];
}

#pragma mark - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissModalViewControllerAnimated:YES];
	
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	
	IFFilterPreviewViewController *preview = [[IFFilterPreviewViewController alloc] init];
	preview.originalImage = image;
	[self.navigationController pushViewController:preview animated:YES];
	[preview release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Cleanup

- (void)dealloc
{
	[imagePicker release];
	
    [super dealloc];
}

@end
