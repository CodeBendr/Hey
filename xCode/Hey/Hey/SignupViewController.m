//
//  SignupViewController.m
//  Hey
//
//  Created by CodeBender on 10/24/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

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
    
    [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"signupView"]]];
    UIImageView *intro = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 116)];
    intro.image = [UIImage imageNamed:@"intro_logo.png"];
    [self.signUpView setLogo:intro];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
