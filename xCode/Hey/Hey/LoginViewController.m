//
//  LoginViewController.m
//  Hey
//
//  Created by CodeBender on 10/24/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
    
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginView"]]];
    UIImageView *intro = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 116)];
    intro.image = [UIImage imageNamed:@"intro_logo.png"];
    [self.logInView setLogo:intro];
    
    // Set field text color
    [self.logInView.usernameField setTextColor:[UIColor whiteColor]];
    [self.logInView.passwordField setTextColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
