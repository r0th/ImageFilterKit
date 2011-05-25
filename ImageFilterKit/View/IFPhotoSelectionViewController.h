//
//  IFPhotoSelectionViewController.h
//  ImageFilterKit
//
//  Created by Andy Roth on 3/29/11.
//  Copyright 2011 Roozy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IFPhotoSelectionViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
}

- (IBAction) openCamera;
- (IBAction) openLibrary;

@end
