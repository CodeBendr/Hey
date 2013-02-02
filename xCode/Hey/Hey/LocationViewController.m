//
//  LocationViewController.m
//  Hey
//
//  Created by Skrizy on 5/13/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "LocationViewController.h"


@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize locationManager;
@synthesize NearByDict;
@synthesize table;
@synthesize activityLocation;
@synthesize searchLocation;
@synthesize stringLocation;
@synthesize stringLat;
@synthesize stringLon;

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

    
    [self.searchLocation setBackgroundImage:[UIImage imageNamed:@"tabBar.png"]];
    
    if ([CLLocationManager locationServicesEnabled]){
        
        if(locationManager == nil){
            
            locationManager                 = [[CLLocationManager alloc] init];
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter  = 1; 
            locationManager.headingFilter   = 5;
           
            locationManager.delegate        = self;
        }
        
        //standard location service
        [locationManager startUpdatingLocation];
        
    }else {
        
        NSLog(@"Access Denied");
        
    } 
    
    UIImageView *imageToolBarButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBar.png"]];
    UIToolbar *buttonToolBar = (UIToolbar*)[self.view viewWithTag:4];
    
    imageToolBarButton.frame = CGRectMake(0, 0, buttonToolBar.frame.size.width, 52);
    [buttonToolBar insertSubview:imageToolBarButton atIndex:1];
    
}

- (void)viewDidUnload{
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [self setTable:nil];
    [self setActivityLocation:nil];
    [self setSearchLocation:nil];
    
    self.stringLat = nil;
    self.stringLocation = nil;
    self.stringLon = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //check to see is a recent location
    NSDate *date             = newLocation.timestamp;
    NSTimeInterval interval  = [date timeIntervalSinceNow];
    
    if (abs(interval) < 30.0) {
        
        //standard implimentation 
        if(newLocation.horizontalAccuracy >= 0.0 && newLocation.horizontalAccuracy < 20.0){
            
            // NSLog(@" lat%.3f , lon%.3f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
            
            //get foursqaure URL and append user location to it
            NSString *fsURL = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%.3f,%.3f&oauth_token=3IYMA1D0J2OFDMORTCOIEWZMLUGW2HCRTMGWSXDQN5RQBGR2&v=20120407",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
            
            NSURL *kFoursqaureURL = [NSURL URLWithString:fsURL];
            
            dispatch_async(kBgQueue, ^{
                
                NSData* data = [NSData dataWithContentsOfURL:kFoursqaureURL];
                
                [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
            });   
            
            
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if(error.code == kCLErrorDenied)
        
        [locationManager startUpdatingLocation];
    
    NSLog(@"Access Denied %@",error.localizedDescription);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access Denied" message:error.localizedFailureReason delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];

}

- (void)fetchedData:(NSData *)responseData {
    
    [locationManager stopUpdatingLocation];
    
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData  options:kNilOptions error:&error];
    
    NSDictionary *response  = [json objectForKey:@"response"]; //2
    self.NearByDict         = [response objectForKey:@"venues"];
    
  //  NSLog(@"%@",self.NearByDict);

    [self.table setHidden:NO];
    [self.activityLocation setHidden:YES];
    
    [self.table reloadData];
    
}  


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.NearByDict.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellLocation";
    UITableViewCell *cell;
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"CellLocationView" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *dic = [self.NearByDict objectAtIndex:indexPath.row];
    UILabel *txtLocation = (UILabel*)[cell viewWithTag:1];
    txtLocation.text     = [dic objectForKey:@"name"];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [self.NearByDict objectAtIndex:indexPath.row];
    stringLocation = [dic objectForKey:@"name"];
    
    NSDictionary *loc = [dic objectForKey:@"location"];
    NSNumber *flLon = [loc objectForKey:@"lng"];
    NSNumber *flLat = [loc objectForKey:@"lat"];
    stringLon = [flLon stringValue];
    stringLat = [flLat stringValue];
    
    
 //   NSLog(@"%@",stringLon);
 //   NSLog(@"%@",stringLat);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
