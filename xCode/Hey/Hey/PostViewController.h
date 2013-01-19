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

@property (strong, nonatomic) IBOutlet UIImageView *imgPost;
@property (strong, nonatomic) IBOutlet UIView *viewChild;
@property (strong, nonatomic) IBOutlet UIImageView *imgBckGrnd;
@property (strong, nonatomic) IBOutlet UITextField *txtPost;
@property (strong, nonatomic) IBOutlet UILabel *txtLocation;
@property (strong, nonatomic) IBOutlet UILabel *txtCategory;
@property (copy, nonatomic) NSString *stringLat;
@property (copy, nonatomic) NSString *stringLon;
@property (strong, nonatomic) IBOutlet UIView *viewRequestProcess;

@property (strong, nonatomic) LocationViewController *locationController;
@property (strong, nonatomic) CategoryViewController *categoryController;

@property (strong, nonatomic) IBOutlet UIView *viewIndicator;
@property (strong, nonatomic) NSTimer *blink;
- (IBAction)sendPostToServer:(id)sender;

- (IBAction)showCategories:(id)sender;

- (IBAction)showLocation:(id)sender;
@end
