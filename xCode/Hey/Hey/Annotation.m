//
//  Annotation.m
//  HotSpot
//
//  Created by Skrizy on 3/26/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate;
@synthesize annotationView;
@synthesize selectedIndex;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c{

    if(self = [super init]){
    
       self.coordinate = c;
    
    }

    return self;

}



@end
