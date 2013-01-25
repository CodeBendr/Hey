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
@synthesize txtCaption;
@synthesize mapDetail;
@synthesize toolbar;
@synthesize imgDetail;
@synthesize viewDetail;
@synthesize scrollDetail;
@synthesize activityDetail;
@synthesize txtTimeStamp;
@synthesize txtLocation;
@synthesize txtChecked;
@synthesize mediaID;
@synthesize urlString;
@synthesize titleString;


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
    
    scrollDetail.contentSize = CGSizeMake(viewDetail.frame.size.width, viewDetail.frame.size.height);
    
    self.mapDetail.layer.cornerRadius = 3;
    
    [[mapDetail layer] setShadowColor:[UIColor blackColor].CGColor];
    [[mapDetail layer] setShadowOpacity:1.0f];
    
  //  self.view.frame = CGRectMake(0, -80, 320 , 480);

}


- (void)updateLikes:(NSData *)responseData {
    

  //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData  options:kNilOptions error:&error];
    
    NSString *stringData = [json objectForKey:@"accessCode"];
    
    if([stringData isEqualToString:@"valid"]){
        
        self.txtLikes.text = [[json objectForKey:@"likes"] stringValue];
        
    }else if([stringData isEqualToString:@"error"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dislike Error" message:@"Hey!! You Can't Like This Post Twice" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
}

- (void)updateDisLikes:(NSData *)responseData {
    
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData  options:kNilOptions error:&error];
    
    NSString *stringData = [json objectForKey:@"accessCode"];
    
    if([stringData isEqualToString:@"valid"]){
        
        self.txtDislikes.text = [[json objectForKey:@"dislikes"] stringValue];
        
    }else if([stringData isEqualToString:@"error"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dislike Error" message:@"Hey!! You Can't Dislike This Post Twice" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
        
    }
    
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
    UIImageWriteToSavedPhotosAlbum(imgDetail.image, nil, nil, nil);

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
        
        [self presentModalViewController:mailVC animated:YES];
    }
    else
    {
        NSLog(@"Error: Mail Unavailable");
    }
}

- (void)sendTweet {
    
    if([TWTweetComposeViewController canSendTweet]){
        
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:self.titleString];
        
        if(self.imgDetail){
            
            [tweetSheet addImage:self.imgDetail.image];
        }
        
       // if (self.urlString){
            
            
         //   [tweetSheet addURL:[NSURL URLWithString:self.urlString]];
     //   }
        
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
            
            if(result == TWTweetComposeViewControllerResultCancelled){
                
                [self dismissModalViewControllerAnimated:YES];
                NSLog(@"Tweet Cancelled");
                
            }else if (result == TWTweetComposeViewControllerResultDone) {
                
                [self dismissViewControllerAnimated:YES completion:^(void){
                
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey! Tweet Sent" message:@"Tweet Sent Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    
                    [alert show];

                }];
            }
         };
        
        [self presentModalViewController:tweetSheet animated:YES];
        
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
    
    [self dismissModalViewControllerAnimated:YES];
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
    
    [self dismissModalViewControllerAnimated:YES];
}



@end
