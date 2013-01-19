//
//  ViewController.h
//  Hey
//
//  Created by Skrizy on 7/7/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuViewController.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) MenuViewController *menu;

@property (strong, nonatomic) IBOutlet UIImageView *intro_logo;

@property (strong, nonatomic) IBOutlet UIImageView *intro_text;


@end
