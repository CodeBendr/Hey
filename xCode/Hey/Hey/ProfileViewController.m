//
//  ProfileViewController.m
//  Hey
//
//  Created by CodeBender on 8/13/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "ProfileViewController.h"
#import "NavigationBarButtons.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController



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
    
    if ([PFUser currentUser]) {
     
        PFUser *user = [PFUser currentUser];
        self.txtUserName.text = [user objectForKey:@"username"];
    
    }
    

   
}



- (void)viewDidUnload{
    
  }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}






@end
