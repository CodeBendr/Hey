//
//  MenuViewController.h
//  Hey
//
//  Created by Skrizy on 7/15/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface MenuViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


- (IBAction)addMediaAction:(id)sender;
- (IBAction)listViewAction:(id)sender;
- (IBAction)profileViewAction:(id)sender;
- (IBAction)mapViewAction:(id)sender;
- (IBAction)searchViewAction:(id)sender;
- (void)showlistView;


@end
