//
//  DetailViewController.h
//  Hey
//
//  Created by Skrizy on 7/8/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController <UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic,copy)  NSString *urlString;
@property (nonatomic,copy)  NSString *titleString;

@property (strong, nonatomic) IBOutlet UILabel *txtCaption;
@property (strong, nonatomic) IBOutlet MKMapView *mapDetail;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIImageView *imgDetail;
@property (strong, nonatomic) IBOutlet UIView *viewDetail;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollDetail;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityDetail;
@property (strong, nonatomic) IBOutlet UILabel *txtTimeStamp;
@property (strong, nonatomic) IBOutlet UILabel *txtLocation;
@property (strong, nonatomic) IBOutlet UILabel *txtChecked;
@property (copy, nonatomic)  NSString *mediaID;
@property (strong, nonatomic) IBOutlet UILabel *txtDislikes;
@property (strong, nonatomic) IBOutlet UILabel *txtLikes;
@property (strong, nonatomic) IBOutlet UILabel *txtComment;

- (IBAction)sendtoAction:(id)sender;

- (IBAction)likeThisPost:(id)sender;

@end
