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

@interface PostViewController : UIViewController <CLLocationManagerDelegate,MBProgressHUDDelegate>{
    
    CLLocationManager *_locationManager;
    CLGeocoder *_geoCoder;
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
    
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

@property (strong, nonatomic) LocationViewController *locationController;
@property (strong, nonatomic) CategoryViewController *categoryController;

@property (weak, nonatomic) IBOutlet UIView *viewIndicator;
@property (weak, nonatomic) NSTimer *blink;

- (IBAction)sendPostToServer:(id)sender;

- (IBAction)showCategories:(id)sender;

- (IBAction)showLocation:(id)sender;
@end
