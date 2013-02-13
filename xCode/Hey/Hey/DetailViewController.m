//
//  DetailViewController.m
//  Hey
//
//  Created by Skrizy on 7/8/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//


#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController
/*@synthesize txtCaption;
@synthesize mapDetail;
@synthesize toolbar;
@synthesize imgDetail;
@synthesize viewDetail;
@synthesize scrollDetail;
@synthesize activityDetail;
@synthesize txtTimeStamp;
@synthesize txtLocation;
@synthesize txtChecked;
@synthesize urlString;
@synthesize titleString;*/
@synthesize mediaID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollDetail.contentSize = CGSizeMake(self.viewDetail.frame.size.width, self.viewDetail.frame.size.height);
    
    [self.viewDetail setHidden:NO];
    
    self.mapDetail.layer.cornerRadius = 3;
    
    UIButton *logo = [[UIButton alloc] initWithFrame:CGRectMake(0, -20, 40, 39)];
    [logo setImage:[UIImage imageNamed:@"navi_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem *logoRight = [[UIBarButtonItem alloc] initWithCustomView:logo];
    
    self.navigationController.navigationItem.rightBarButtonItem = logoRight;

    
    [[self.mapDetail layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self.mapDetail layer] setShadowOpacity:1.0f];
    
  //  self.view.frame = CGRectMake(0, -80, 320 , 480);

}






- (void)viewDidUnload
{
    [self setTxtCaption:nil];
    [self setMapDetail:nil];
    [self setImgDetail:nil];
    [self setScrollDetail:nil];
    [self setViewDetail:nil];
    [self setActivityDetail:nil];
    [self setTxtTimeStamp:nil];
    [self setTxtLocation:nil];
    [self setTxtChecked:nil];
    [self setMediaID:nil];
    [self setToolbar:nil];
    [self setTxtDislikes:nil];
    [self setTxtLikes:nil];
    [self setTxtComment:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.titleString = nil;
    self.urlString = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (void)cameraRoll {

    //save picture to the camera roll
    UIImageWriteToSavedPhotosAlbum(self.imgDetail.image, nil, nil, nil);

}

- (void)SendMessage{
    
    if ([MFMessageComposeViewController canSendText]){
        
        MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc]
                                                     init];
        messageVC.messageComposeDelegate = self;
        messageVC.recipients = [NSArray arrayWithObject:@""];
        messageVC.body = @"http://hey.com/API/media.php/CRX165r";
        [self presentViewController:messageVC animated:YES completion:nil];
        
    }
    else
    {
        NSLog(@"Error, Text Messaging Unavailable");
    }
    
}

- (void)sendMail{
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        
        [mailVC setSubject:self.titleString];
        [mailVC setToRecipients:[NSArray arrayWithObject:@""]];
        [mailVC setMessageBody:@"http://hey.com/API/media.php/CRX165r" isHTML:NO];
        mailVC.mailComposeDelegate = self;
        
        /////NEW IMAGE CODE
        if (self.imgDetail != nil){
            
            NSData *imageData = UIImageJPEGRepresentation(self.imgDetail.image, 1.0);
            [mailVC addAttachmentData:imageData mimeType:@"image/jpeg"
                             fileName:@"heyImage"];
        }
        
        [self presentViewController:mailVC animated:YES completion:nil];
    }
    else
    {
        NSLog(@"Error: Mail Unavailable");
    }
}

- (void)sendTweet {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:self.titleString];
        
        if(self.imgDetail){
            
            [tweetSheet addImage:self.imgDetail.image];
        }
        
       // if (self.urlString){
            
            
         //   [tweetSheet addURL:[NSURL URLWithString:self.urlString]];
     //   }
        
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result){
            
            if(result == SLComposeViewControllerResultCancelled){
                
            [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Tweet Cancelled");
                
            }else if (result == SLComposeViewControllerResultDone) {
                
                [self dismissViewControllerAnimated:YES completion:^(void){
                
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey! Tweet Sent" message:@"Tweet Sent Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    
                    [alert show];

                }];
            }
         };
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}


- (void)sendFacebookPost {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText:self.titleString];
        
        if(self.imgDetail){
            
            [fbSheet addImage:self.imgDetail.image];
        }
        
        fbSheet.completionHandler = ^(SLComposeViewControllerResult result){
            
            if(result == SLComposeViewControllerResultCancelled){
                
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"Facebook Post Cancelled");
                
            }else if (result == SLComposeViewControllerResultDone) {
                
                [self dismissViewControllerAnimated:YES completion:^(void){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey! Facebook Post Sent" message:@"Facebook Post Sent Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    
                    [alert show];
                    
                }];
            }
        };
        
        [self presentViewController:fbSheet animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a facebook post right now, make sure your device has an internet connection and you have at least one facebook account setup"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}



- (IBAction)sendtoAction:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"View Comments",@"Share on Twitter",@"Share on Facebook",@"Save to Camera Roll",@"Email Post",@"Send as Message",@"Report Post",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = 1;
    
    [actionSheet showInView:self.view];
    
}

- (IBAction)likeThisPost:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Like",@"Dislike",@"Comment",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = 2;
    
    [actionSheet showInView:self.view];
}




#pragma mark actionsheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    if(actionSheet.tag == 1){
    
    switch (buttonIndex) {
            
        case 0:
           // [self viewComments];
            break;
            
        case 1:
           [self sendTweet];
            break;
            
        case 2:
            
            break;
            
        case 3:
            [self cameraRoll];
            break;
            
        case 4:
            [self sendMail];
            break;
            
        case 5:
            [self SendMessage];
            break;
            
        default:
            break;
    }
        
    }else{
    
        
        switch (buttonIndex) {
                
            case 0:
            //  [self likePost];
                break;
                
            case 1:
               // [self dislikePost];
                break;
                
            case 2:
           //     [self showCommentView];
                break;
                
            default:
                break;
        }
    
    }
}


#pragma mark mail delegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result{
    
    if (result == MessageComposeResultSent){
        
        
        
    }else if (result == MessageComposeResultFailed){
        
        NSLog(@"Message Failed to Send!");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
        
        NSLog(@"Mail Successfully Sent");
    
    else if (result == MFMailComposeResultCancelled)
        
        NSLog(@"Mail Cancelled");
    
    else if (result == MFMailComposeResultFailed)
        
        NSLog(@"Error, Mail Send Failed");
    
    else if (result == MFMailComposeResultSaved)
        
        NSLog(@"Mail Saved");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
