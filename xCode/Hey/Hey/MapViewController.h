//
//  MapViewController.h
//  Hey
//
//  Created by Skrizy on 7/19/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>{

    int count;
    int length;

}

- (IBAction)showMenu:(id)sender;

@property (strong,nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet MKMapView *nearbyMap;

@property (strong, nonatomic) NSMutableDictionary *mainPix;

@property (strong, nonatomic) NSArray *locationList;

@end
