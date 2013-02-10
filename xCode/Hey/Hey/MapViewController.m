//
//  MapViewController.m
//  Hey
//
//  Created by Skrizy on 7/19/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"
#import "AnnotationButton.h"
#import "CustomAnnotationView.h"
#import "DetailViewController.h"
#import "NavigationBarButtons.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize locationList;
@synthesize mainPix;
@synthesize locationManager;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)closeMenu:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //create the add button and add it to the left side of the navigator
    UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 31)];
    [btnList setImage:[UIImage imageNamed:@"btnListGlobal.png"] forState:UIControlStateNormal];
    [btnList addTarget:self action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnListLeft = [[UIBarButtonItem alloc] initWithCustomView:btnList];
    
    self.navigationItem.leftBarButtonItem  = btnListLeft;
    
    NavigationBarButtons *navi = [NavigationBarButtons alloc];
    [navi navigationBarButtonsForControllers:self];
    
   }

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
  
    
    
    [locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if(error.code == kCLErrorDenied)
        
        [locationManager startUpdatingLocation];
    
    NSLog(@"Access Denied %@",error.localizedDescription);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access Denied" message:error.localizedFailureReason delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    
}

- (void)viewDidUnload
{
     [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showMenu:(id)sender {
    
 [self.navigationController.view setAlpha:0];
    
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
        
    return NULL;
    
}



@end
