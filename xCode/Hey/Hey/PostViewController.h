//
//  PostViewController.h
//  Hey
//
//  Created by Skrizy on 7/24/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "CoreLocation/CoreLocation.h"
#import "LocationViewController.h"
#import "CategoryViewController.h"
#import "MBProgressHUD.h"
#import <Parse/Parse.h>

@interface PostViewController : UIViewController <CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>{
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geoCoder;
    
  //  MBProgressHUD *HUD;
   // MBProgressHUD *refreshHUD;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imgPost;
@property (weak, nonatomic) IBOutlet UIView *viewChild;
@property (weak, nonatomic) IBOutlet UIImageView *imgBckGrnd;
@property (weak, nonatomic) IBOutlet UITextField *txtPost;
@property (weak, nonatomic) IBOutlet UILabel *txtLocation;
@property (weak, nonatomic) IBOutlet UILabel *txtCategory;
@property (copy, nonatomic) NSString *stringLat;
@property (copy, nonatomic) NSString *stringLon;
@property (weak, nonatomic) IBOutlet UIView *viewRequestProcess;
@property (weak, nonatomic) IBOutlet UILabel *txtChooseImage;
@property (weak, nonatomic) IBOutlet UILabel *txtPostCharAtOne;
@property (weak, nonatomic) IBOutlet UILabel *txtLocationCharAtOne;

@property (strong, nonatomic) LocationViewController *locationController;
@property (strong, nonatomic) CategoryViewController *categoryController;
- (IBAction)changeImage:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewIndicator;
@property (weak, nonatomic) NSTimer *blink;

-(NSString*)getFirstCharacterFromString:(NSString *)character;

- (IBAction)sendPostToServer:(id)sender;

- (IBAction)showCategories:(id)sender;

- (IBAction)showLocation:(id)sender;
@end
