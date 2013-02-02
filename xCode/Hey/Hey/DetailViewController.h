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

@property (weak, nonatomic) IBOutlet UILabel *txtCaption;
@property (weak, nonatomic) IBOutlet MKMapView *mapDetail;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *imgDetail;
@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollDetail;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityDetail;
@property (weak, nonatomic) IBOutlet UILabel *txtTimeStamp;
@property (weak, nonatomic) IBOutlet UILabel *txtLocation;
@property (weak, nonatomic) IBOutlet UILabel *txtChecked;
@property (copy, nonatomic)  NSString *mediaID;
@property (weak, nonatomic) IBOutlet UILabel *txtDislikes;
@property (weak, nonatomic) IBOutlet UILabel *txtLikes;
@property (weak, nonatomic) IBOutlet UILabel *txtComment;
@property (weak, nonatomic) IBOutlet UILabel *txtUsername;
@property (weak, nonatomic) IBOutlet UILabel *txtType;


- (IBAction)sendtoAction:(id)sender;

- (IBAction)likeThisPost:(id)sender;

@end
