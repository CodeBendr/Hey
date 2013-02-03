//
//  PostViewController.m
//  Hey
//
//  Created by Skrizy on 7/24/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "PostViewController.h"

#import "SignUpViewController.h"
#import "MenuViewController.h"
#import "MediaViewController.h"
#import "UIImage+ResizeAdditions.h"
#import "NavigationBarButtons.h"
#import "NSString+Manipulation.h"
#import "ListViewController.h"

@interface PostViewController ()

@property (nonatomic,strong) NSMutableData *receivedData;

@end

@implementation PostViewController
/*@synthesize imgPost;
@synthesize viewChild;
@synthesize imgBckGrnd;
@synthesize txtPost;
@synthesize txtLocation;
@synthesize txtCategory;
@synthesize blink;
@synthesize viewIndicator;
@synthesize stringLat;
@synthesize stringLon;
@synthesize viewRequestProcess;
@synthesize receivedData; */

@synthesize locationController;
@synthesize categoryController;

- (void)blinkIndicator{
    
    [self.viewIndicator setAlpha:0.0];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         [self.viewIndicator setAlpha:1.0];                
                         
                     } 
                     completion:nil];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // self.viewIndicator.layer.cornerRadius = 8.0;
    
    
     NavigationBarButtons *navi = [NavigationBarButtons alloc];
    [navi navigationBarButtonsForControllers:self];
    
     self.blink = [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(blinkIndicator) userInfo:nil repeats:YES];
    
     //[txtPost becomeFirstResponder];
    
     //configure fonts for view
     [self.txtLocation setFont:[UIFont fontWithName:@"Lato-Light" size:35]];
     [self.txtPost setFont:[UIFont fontWithName:@"Lato-Light" size:35]];
     [self.txtCategory setFont:[UIFont fontWithName:@"Lato-Light" size:18]];
     [self.txtPostCharAtOne setFont:[UIFont fontWithName:@"Lato-Light" size:21]];
     [self.txtLocationCharAtOne setFont:[UIFont fontWithName:@"Lato-Light" size:21]];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    if(self.locationController.stringLocation != nil){
        
        self.txtLocation.text =  self.locationController.stringLocation;
        self.stringLat = self.locationController.stringLat;
        self.stringLon = self.locationController.stringLon;
    }
    
    if(self.categoryController.stringCategory != nil){
        
      //  self.txtCategory.textColor = [UIColor colorWithRed:12 green:160 blue:203 alpha:0.0f];
        self.txtCategory.text      = self.categoryController.stringCategory;
        
    }
    
}

- (void)viewDidUnload
{
    [self setImgPost:nil];
    [self setViewIndicator:nil];
    [self setViewChild:nil];
    [self setTxtPost:nil];
    [self setTxtLocation:nil];
    [self setTxtCategory:nil];
    [self setImgBckGrnd:nil];
    
    [self setViewRequestProcess:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.locationController = nil;
    self.categoryController = nil;
    self.stringLon = nil;
    self.stringLat = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)sendPostToServer:(id)sender {
    
    if([self.txtPost.text length] != 0 && [self.txtLocation.text length] != 0 && [self.txtCategory.text length] != 0
      && ![self.txtLocation.text isEqualToString:@"Find Location" ] && ![self.txtLocation.text isEqualToString:@"Searching" ] &&  ![self.txtCategory.text isEqualToString:@"Choose Category"]
      && self.imgPost.image != nil){
        
        
        UIImage *resizedImage = [self.imgPost.image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(560.0f, 560.0f) interpolationQuality:kCGInterpolationHigh];
        UIImage *thumbnailImage = [self.imgPost.image thumbnailImage:99.0f transparentBorder:0.0f cornerRadius:0.0f interpolationQuality:kCGInterpolationDefault];
        
        // JPEG to decrease file size and enable faster uploads & downloads
        NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.8f);
        NSData *thumbnailImageData = UIImagePNGRepresentation(thumbnailImage);
    
       PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
        
        //HUD
     //   HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.viewRequestProcess setHidden:NO];
     //   [self.viewRequestProcess addSubview:HUD];

        
        // Save PFFile
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if (!error) {
                // Hide old HUD, show completed HUD (see example for code)
                
                // Create a PFObject around a PFFile and associate it with the current user
                PFObject *uploadMedia = [PFObject objectWithClassName:@"Media"];
                [uploadMedia setObject:imageFile forKey:@"file"];
                
                // Set the access control list to current user for security purposes
                PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
                [photoACL setPublicReadAccess:YES];
                 uploadMedia.ACL = photoACL;
                
                PFUser *user = [PFUser currentUser];
                [uploadMedia setObject:user forKey:@"postedBy"];
                
                [uploadMedia setObject:self.txtPost.text      forKey:@"caption"];
                [uploadMedia setObject:self.txtCategory.text  forKey:@"category"];
                [uploadMedia setObject:self.txtLocation.text  forKey:@"location"];
                PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:[self.stringLat doubleValue] longitude:[self.stringLon doubleValue]];
                [uploadMedia setObject:point forKey:@"latlong"];
                [uploadMedia setObject:@"picture" forKey:@"type"];
                
                 PFFile *thumbnailFile = [PFFile fileWithName:@"thumb" data:thumbnailImageData];
                [uploadMedia setObject:thumbnailFile forKey:@"thumbnail"];
                
                [uploadMedia saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (!error) {
                        
                        // Save the files
                        [thumbnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                           
                            if (!error) {
                            
                                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^(void){
                                
                                
                                    ListViewController *list = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
                                    [super presentViewController:list animated:YES completion:nil];
                                    
                                    
                                }];
                            
                            }else{
                            
                                // Log details of the failure
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Upload Image" message:@"Hey! couldn't upload image at this time the connection to the server filed" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                                
                                 [alert show];
                             }
                            
                         }];
                        
                    }else{
                        
                        // Log details of the failure
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Upload Image" message:@"Hey! couldn't upload image at this time" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                        
                        [alert show];
                        
                    }
                }];
            }
            else{
                
             //   [HUD hide:YES];
                [self.viewRequestProcess setHidden:YES];
                
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
            
        } progressBlock:^(int percentDone) {
            
            // Update your progress spinner here. percentDone will be between 0 and 100.
        //    HUD.progress = (float)percentDone/100;
            
        }];
               
    
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please make sure all required fields are filled." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    
    }
}

- (IBAction)showCategories:(id)sender {
    
     [UIView transitionWithView:self.viewChild duration:0.2 options:UIViewAnimationCurveLinear animations:^(void){
        
         self.viewChild.frame = CGRectMake(0, -44, 320, 460);
         self.imgBckGrnd.frame = CGRectMake(0, -44, 320, 460);
    
    } completion:^(BOOL finished){
    
        [self.txtPost resignFirstResponder];
        
        self.viewIndicator.frame = CGRectMake(22, 240, 7, 9);
        
         categoryController = [[CategoryViewController alloc]  initWithNibName:@"CategoryViewController" bundle:nil];
        
        [self.navigationController pushViewController:categoryController animated:YES];
    
    }];
    
}

- (IBAction)showLocation:(id)sender {
    
    [UIView transitionWithView:self.viewChild duration:0.1 options:UIViewAnimationCurveLinear animations:^(void){
        
        self.viewChild.frame = CGRectMake(0, -44, 320, 460);
        self.imgBckGrnd.frame = CGRectMake(0, -44, 320, 460);
        
    } completion:^(BOOL finished){
    
        [self.txtPost resignFirstResponder];
        
        self.viewIndicator.frame = CGRectMake(20, 280, 9, 9);
        
        if([CLLocationManager locationServicesEnabled]){
            
            if([sender isKindOfClass:[UIButton class]]){
                
                if(_locationManager == nil){
                    
                    _locationManager                 = [[CLLocationManager alloc] init];
                    _locationManager.delegate        = self;
                    _locationManager.distanceFilter  = 500;
                    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
                   
                }
                
                 self.txtLocation.text = @"Searching";
                [_locationManager startUpdatingLocation];

            }
            
        }else{
            
            self.locationController  = [[LocationViewController alloc]  initWithNibName:@"LocationViewController" bundle:nil];
            [self.navigationController pushViewController:self.locationController animated:YES];
            [_locationManager stopUpdatingLocation];
        }
       
    
    }];
    
   
}

#pragma textfield delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    [UIView transitionWithView:self.viewChild duration:0.1 options:UIViewAnimationCurveLinear animations:^(void){
        
        CGRect anim      = CGRectMake(0, -140, 320, 460);
        self.viewChild.frame  = anim;
        self.imgBckGrnd.frame = CGRectMake(0, -140, 320, 460);
        
    } completion:nil];
    
     self.viewIndicator.frame = CGRectMake(23, 210, 7, 9);
        
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [UIView transitionWithView:self.viewChild duration:0.2 options:UIViewAnimationCurveLinear animations:^(void){
        
        self.viewChild.frame = CGRectMake(0, -44, 320, 460);
        self.imgBckGrnd.frame = CGRectMake(0, -44, 320, 460);
        
    } completion:nil];
    
 //    self.viewIndicator.frame = CGRectMake(23, 179, 7, 9);
    
    return NO;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    
}

- (IBAction)removeKeyboardOnBckGrnd:(id)sender{
    
    [self.txtPost resignFirstResponder];
    
    [UIView transitionWithView:self.viewChild duration:0.2 options:UIViewAnimationCurveLinear animations:^(void){
        
        self.viewChild.frame = CGRectMake(0, -44, 320, 460);
        self.imgBckGrnd.frame = CGRectMake(0, -44, 320, 460);
        
    } completion:nil];
    
}







#pragma location delegations

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if(error.code==kCLErrorDenied){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access Denied" message:@"Location information denied" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    }
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation
                                                                         *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSDate *locationDate= newLocation.timestamp;
    
    NSTimeInterval locationInterval = [locationDate timeIntervalSinceNow];
    
    if(abs(locationInterval) < 30){
        
        if(newLocation.horizontalAccuracy < 0)
            return;
        
        //Instantiate _geoCoder if it has not been already
        if(_geoCoder==nil)
            _geoCoder=[[CLGeocoder alloc] init];
        
        //Only one geocoding instance per action
        //so stop any previous geocoding actions before starting this one
        if([_geoCoder isGeocoding])
            [_geoCoder cancelGeocode];
        
        /*   [_geoCoder geocodeAddressString:@"Creative Factory, 4th norla street, accra"
         completionHandler:^(NSArray* placemarks, NSError* error){
         for (CLPlacemark* aPlacemark in placemarks)
         {
         // Process the placemark.
         NSLog(@"%g",aPlacemark.location.coordinate.longitude);
         NSLog(@"%g",aPlacemark.location.coordinate.latitude);
         }
         }];*/
        
        [_geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks, NSError* error){
                            
                            if([placemarks count] > 0){
                                
                                CLPlacemark *foundPlacemark= [placemarks objectAtIndex:0];
                                
                                self.txtLocation.text = foundPlacemark.name;
                                
                              self.stringLat = [NSString stringWithFormat:@"%g",foundPlacemark.location.coordinate.latitude];
                              self.stringLon = [NSString stringWithFormat:@"%g",foundPlacemark.location.coordinate.longitude];
                                
                            }else if(error.code == kCLErrorGeocodeCanceled){
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Found" message:@"Location not found" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                                
                                [alert show];
                                
                            }else if(error.code == kCLErrorGeocodeFoundNoResult){
                                
                             self.locationController  = [[LocationViewController alloc]  initWithNibName:@"LocationViewController" bundle:nil];
                             [self.navigationController pushViewController:self.locationController animated:YES];
                                
                            }else if(error.code == kCLErrorGeocodeFoundPartialResult){
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Found" message:@"Location not found" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                                
                                [alert show];
                                
                            }else{
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Error" message:error.description delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
                                
                                [alert show];
                            }
                            
                        }];
        
        //Stop updating location until they click the button again
        [manager stopUpdatingLocation];
    }
}



#pragma mark change image


- (IBAction)changeImage:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Media" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"From Camera",@"From Library",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
        
        //check to see if the device camera is available
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Camera Unavailable"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }else{
            
            
            //create an instance to load the device camera
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate                 = self;
            picker.allowsEditing            = YES;
            picker.sourceType               = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }
        
		
        
		
    } else if (buttonIndex == 1) {
        
        //check to see if the device camera is available
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Camera Unavailable"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }else{
            
            //create an instance to load the device camera
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate                 = self;
            picker.allowsEditing            = YES;
            picker.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
        }
		
        
    }
}

#pragma mark -
#pragma mark image picker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    //create an instance of UIImage to point to the snapped picture by type casting
    
    // UIImage *img = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *img = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    
    
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        self.imgPost.image       = img;
        
    }];
    
    //save picture to the camera roll
    // UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    
    // self.imageSelected.image = img;
    
    // self.imageSelected.contentMode = UIViewContentModeScaleAspectFit;
    
    /* if ([picker sourceType] == UIImagePickerControllerSourceTypePhotoLibrary) {
     
     // Get the asset url
     NSURL *url = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
     
     // We need to use blocks. This block will handle the ALAsset that's returned:
     ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
     {
     // Get the location property from the asset
     CLLocation *location = [myasset valueForProperty:ALAssetPropertyLocation];
     
     if(location != nil)
     
     NSLog(@"%.5f°",location.coordinate.latitude);
     
     };
     
     // This block will handle errors:
     ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
     {
     NSLog(@"Can not get asset - %@",[myerror localizedDescription]);
     // Do something to handle the error
     };
     
     
     // Use the url to get the asset from ALAssetsLibrary,
     // the blocks that we just created will handle results
     ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
     [assetslibrary assetForURL:url
     resultBlock:resultblock
     failureBlock:failureblock];
     
     }*/
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
       
    self.txtPostCharAtOne.text = [self getFirstCharacterFromString:textField.text];
    
    return YES;

}

-(NSString*)getFirstCharacterFromString:(NSString *)character{
    
    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray * words = [character componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    for (NSString * word in words) {
        
        if ([word length] > 0) {
            NSString * firstLetter = [word substringWithRange:[word rangeOfComposedCharacterSequenceAtIndex:0]];
            [firstCharacters appendString:[firstLetter uppercaseString]];
        }
    }
    
    return firstCharacters;
    
}







@end








