//
//  CategoryViewController.m
//  Hey
//
//  Created by Skrizy on 5/24/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "CategoryViewController.h"
#import "TableCategoryView.h"
#import "NavigationBarButtons.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize categoryArray;
@synthesize stringCategory;


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
    // Do any additional setup after loading the view from its nib.
    
    
    TableCategoryView *table = [[TableCategoryView alloc] initWithClassName:@"Category"];
    [self addChildViewController:table];
    table.view.frame = CGRectMake(0.f, 0.f, 320.f, 480.f);
	[self.view addSubview:table.view];
    
    //create the add button and add it to the right side of the navigator
    UIButton *btnList = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 31)];
    [btnList setImage:[UIImage imageNamed:@"btnListGlobal.png"] forState:UIControlStateNormal];
    [btnList addTarget:self action:@selector(closeMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnListLeft = [[UIBarButtonItem alloc] initWithCustomView:btnList];
    
    self.navigationItem.leftBarButtonItem = btnListLeft;
    
    NavigationBarButtons *navi = [NavigationBarButtons alloc];
    [navi navigationBarButtonsForControllers:self];
    
  
}

- (void)viewDidUnload
{
   
    [super viewDidUnload];
    self.categoryArray = nil;
    self.stringCategory = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.categoryArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellLocation";
    UITableViewCell *cell;
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"CellLocationView" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        
    UILabel *txtCategory = (UILabel*)[cell viewWithTag:1];
    [txtCategory setFont:[UIFont fontWithName:@"Lato-Regular" size:18]];
     txtCategory.text     = [self.categoryArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   stringCategory = [self.categoryArray objectAtIndex:indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}*/

@end
