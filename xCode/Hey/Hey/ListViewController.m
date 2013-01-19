//
//  MainViewController.m
//  Hey
//
//  Created by Skrizy on 7/7/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "ListViewController.h"
#import "TableListView.h"
#import "MenuViewController.h"
#import "MediaViewController.h"
#import "SignUpViewController.h"


@interface ListViewController (){

    int count;
    
}

@property (nonatomic,copy) UILabel *txtRefresh;

@end

@implementation ListViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
     
    }
    return self;
}

- (void)closeMenu:(id)sender{
  
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TableListView *table = [[TableListView alloc] initWithClassName:@"Media"];
    [self addChildViewController:table];
    table.view.frame = CGRectMake(0.f, 0.f, 320.f, 480.f);
	[self.view addSubview:table.view];
      
    //create the add button and add it to the right side of the navigator
    UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 31)];
    [btnList setImage:[UIImage imageNamed:@"btnListGlobal.png"] forState:UIControlStateNormal];
    [btnList addTarget:self action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnListLeft = [[UIBarButtonItem alloc] initWithCustomView:btnList];
    
    self.navigationItem.leftBarButtonItem = btnListLeft;
    
    
 }

#pragma mark -
#pragma mark unload views

- (void)viewDidUnload
{
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark map view delegates



#pragma mark -
#pragma mark table view delegates






@end
