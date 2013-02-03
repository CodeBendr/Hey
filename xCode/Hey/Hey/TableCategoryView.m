//
//  TableListView.m
//  Hey
//
//  Created by CodeBender on 10/29/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "TableCategoryView.h"
#import "CategoryViewController.h"



@interface TableCategoryView ()

@end

@implementation TableCategoryView
@synthesize stringCategory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        // Custom initialization

        if (self) {
            // Custom the table 
            
            // The className to query on
            self.className = @"Category";
            
            // The key of the PFObject to display in the label of the default cell style
            // self.keyToDisplay = @"text";
            
            // Whether the built-in pull-to-refresh is enabled
            self.pullToRefreshEnabled = YES;
            
            // Whether the built-in pagination is enabled
            self.paginationEnabled = YES;
        
            
            // The number of objects to show per page
            self.objectsPerPage = 7;
            
        }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.tableView setRowHeight:46];
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleGray];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    //include keys
   // [query includeKey:@"postedBy"];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    
    if ([self.objects count] == 0) {
        
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
    }
    
    
   [query orderByAscending:@"type"];

    return query;
}




// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
   [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    static NSString *CellIdentifier = @"CategoryListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"CellLocationView" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *txtCategory = (UILabel*)[cell viewWithTag:1];
    [txtCategory setFont:[UIFont fontWithName:@"Lato-Light" size:18]];



    //text information related to list object
    txtCategory.text  = [object objectForKey:@"type"];
   
      
    return cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NextPage";
    
    UITableViewCell *cell;
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"CellLocationView" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *txtCategory = (UILabel*)[cell viewWithTag:1];
    [txtCategory setFont:[UIFont fontWithName:@"Lato-Light" size:18]];
    
    //text information related to list object
    txtCategory.text  = @"Load More";

    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     PFObject *object = [self.objects objectAtIndex:indexPath.row];
    
    CategoryViewController *category = (CategoryViewController*)self.parentViewController;
    category.stringCategory = [object objectForKey:@"type"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
 }

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollViewH willDecelerate:(BOOL)decelerate {
    
    //  NSLog(@"table did end dragging");
    
    
    
  //  CGFloat contentOffsetY = scrollViewH.contentOffset.y;
    
   // NSLog(@"%f",scrollViewH.contentOffset.y);
  
    
}



@end
