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
- (IBAction)chooseVideo:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *chooseAudio;
- (IBAction)closeMediaView:(id)sender;
@end
