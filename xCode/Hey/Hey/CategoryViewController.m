//
//  CategoryViewController.m
//  Hey
//
//  Created by Skrizy on 5/24/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "CategoryViewController.h"

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
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *postURL   = [bundle URLForResource:@"topics" withExtension:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:postURL];
    self.categoryArray = [dic objectForKey:@"item"];
    
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending:YES];
    [categoryArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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
    txtCategory.text     = [self.categoryArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   stringCategory = [self.categoryArray objectAtIndex:indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
