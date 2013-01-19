//
//  LocationViewController.h
//  Hey
//
//  Created by Skrizy on 5/13/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController <CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSArray *NearByDict;
@property (copy, nonatomic) NSString *stringLocation;
@property (copy, nonatomic) NSString *stringLat;
@property (copy, nonatomic) NSString *stringLon;

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityLocation;
@property (strong, nonatomic) IBOutlet UISearchBar *searchLocation;

@end
