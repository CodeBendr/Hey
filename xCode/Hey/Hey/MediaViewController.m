//
//  MediaViewController.m
//  Hey
//
//  Created by Skrizy on 7/23/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "MediaViewController.h"
#import "PostViewController.h"


@interface MediaViewController ()


@end

@implementation MediaViewController


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
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)choosePicture:(id)sender {
    
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
        
         PostViewController *post = [[PostViewController alloc] initWithNibName:@"PostViewController" bundle:nil];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:post];
       
       [self presentViewController:navi animated:YES completion:nil];
         post.imgPost.image       = img;
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

- (IBAction)closeMediaView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^(void){
 
    
    }];
}
@end
