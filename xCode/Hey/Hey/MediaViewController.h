//
//  MediaViewController.h
//  Hey
//
//  Created by Skrizy on 7/23/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

- (IBAction)choosePicture:(id)sender;


@property (weak, nonatomic) IBOutlet UITextView *txtDesc;
@property (weak, nonatomic) IBOutlet UILabel *txtImageLabel;

- (IBAction)closeMediaView:(id)sender;


@end
