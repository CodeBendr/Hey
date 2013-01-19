//
//  MenuViewController.m
//  Hey
//
//  Created by Skrizy on 7/15/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "MenuViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "MediaViewController.h"
#import "ListViewController.h"



@interface MenuViewController ()

@property (nonatomic,strong) NSArray *viewControllers;


@end

@implementation MenuViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
    }
    
    return self;
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
  //  [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
  
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)addMediaAction:(id)sender{
    
    if (![PFUser currentUser]) {
        
        LoginViewController *login = [[LoginViewController alloc] init];
        login.delegate = self;
        
        [login setFields:PFLogInFieldsUsernameAndPassword | PFLogInFieldsSignUpButton | PFLogInFieldsDismissButton];
        
        SignupViewController *signup = [[SignupViewController alloc] init];
        [signup setDelegate:self];
        [signup setFields:PFSignUpFieldsDefault];
        
        [login setSignUpController:signup];
        [self presentViewController:login animated:YES completion:nil];

    }else{
    
        MediaViewController *media = [[MediaViewController alloc] initWithNibName:@"MediaViewController" bundle:nil];
        [self presentViewController:media animated:YES completion:nil];
    
    
    }
    
}

- (IBAction)listViewAction:(id)sender {
    
    ListViewController *list = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:list];
    [self presentViewController:navi animated:YES completion:nil];
    
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    
    BOOL informationComplete = YES;
    
    for (id key in info) {
        
        NSString *field = [info objectForKey:key];
        
        if (!field || field.length == 0) {
            
            informationComplete = NO;
            break;
        }
    }
    
    if (!informationComplete) {
        
        [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    
    NSLog(@"User dismissed the signUpViewController");
}


@end
















