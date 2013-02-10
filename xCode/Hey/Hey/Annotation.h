//
//  Annotation.h
//  HotSpot
//
//  Created by Skrizy on 3/26/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) MKPinAnnotationView *annotationView;
@property NSInteger selectedIndex;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c;


@end
