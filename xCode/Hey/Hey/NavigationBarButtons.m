//
//  NavigationBarButtons.m
//  Hey
//
//  Created by CodeBender on 1/27/13.
//  Copyright (c) 2013 Digital Benders. All rights reserved.
//

#import "NavigationBarButtons.h"

@implementation NavigationBarButtons





- (void)navigationBarButtonsForControllers:(id)parent{
    
    UINavigationController *navi = (UINavigationController*)parent;

    UIButton *logo = [[UIButton alloc] initWithFrame:CGRectMake(0, -20, 40, 39)];
    [logo setImage:[UIImage imageNamed:@"navi_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem *logoRight = [[UIBarButtonItem alloc] initWithCustomView:logo];
    
  //  parent.navigationItem.rightBarButtonItem = logoRight;
    navi.navigationItem.rightBarButtonItem = logoRight;

}



@end
