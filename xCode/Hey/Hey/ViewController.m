//
//  ViewController.m
//  Hey
//
//  Created by Skrizy on 7/7/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController
@synthesize intro_logo;
@synthesize intro_text;
@synthesize menu;

  //load the main view after delay
- (void)loadMainViewAfterDelay{

    menu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];  
    [self presentViewController:menu animated:YES completion:^(void){
        
        [self.view.superview removeFromSuperview];
        
    }];
    
   // [self.view addSubview:menu.view];
    
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //animate the logo and the intro text
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                       
                         self.intro_logo.frame = CGRectMake(60, 134, 202, 189);
                         
                     } 
                     completion:^(BOOL finished){
                         
                         [UIView animateWithDuration:0.2 animations:^{
                         
                         self.intro_logo.frame = CGRectMake(60, 100, 202, 189);
                         
                         } completion:nil];
                         
                         [UIView animateWithDuration:0.4
                                               delay:0.1
                                             options: UIViewAnimationCurveLinear
                                          animations:^{
                                              
                                              self.intro_text.frame = CGRectMake(0, 310, 332, 60);
                                              
                                          } 
                          
                                          completion:^(BOOL finished){
                                              
                                              [UIView animateWithDuration:0.6 animations:^{
                                                  
                                              [self.intro_logo setAlpha:0.0];
                                              [self.intro_text setAlpha:0.0];
                                                  
                                              } completion:nil];
                                              
                                              [self performSelector:@selector(loadMainViewAfterDelay) withObject:nil afterDelay:0.3];
                                              
                                          }];
                     }];
}



- (void)viewDidUnload{
    
    [self setIntro_logo:nil];
    [self setIntro_text:nil];
    [self setMenu:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
