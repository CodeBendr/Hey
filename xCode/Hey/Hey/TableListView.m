//
//  TableListView.m
//  Hey
//
//  Created by CodeBender on 10/29/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "TableListView.h"
#import "ListViewCell.h"
#import "ViewHelper.m"
#import "DetailViewController.h"
#import "NavigationBarButtons.h"

@interface TableListView ()

@end

@implementation TableListView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        // Custom initialization

        if (self) {
            // Custom the table
            
            // The className to query on
            self.className = @"Media";
            
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
    
    [self.tableView setRowHeight:138];
    [self.tableView setSeparatorStyle:UITableViewCellSelectionStyleGray];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) mediaType:(NSString*)type{
    
    
    if([type isEqualToString:@"picture"]){
        
        return @"typePicture.png";
        
    } else if([type isEqualToString:@"video"]){
        
        return @"typeVideo.png";
        
    } else if([type isEqualToString:@"audio"]){
        
        return @"typeAudio.png";
        
    }
    
    return nil;
    
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
    
    
   [query orderByDescending:@"createdAt"];

    return query;
}




// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
   [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    static NSString *CellIdentifier = @"ListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"ListViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //configure cell
    ListViewCell *listViewCell = (ListViewCell*)cell;
   
    PFFile *thumb = [object objectForKey:@"thumbnail"];
    [thumb getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            
            // image can now be set on a UIImageView
            listViewCell.imgThumb.image = [UIImage imageWithData:data];
            
            //animate the logo and the intro text
            [UIView animateWithDuration:0.5
                                  delay:1.0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 
                               [listViewCell.imgThumb setAlpha:1.0f];
                                 
                             } 
                             completion:nil];
        }
    }];
    
    [listViewCell.txtCaption setFont:[UIFont fontWithName:@"Lato-Light" size:26]];
    [listViewCell.txtTime setFont:[UIFont fontWithName:@"Lato-Regular" size:9]];
    [listViewCell.txtUsername setFont:[UIFont fontWithName:@"Lato-Regular" size:11.5]];
    [listViewCell.txtType setFont:[UIFont fontWithName:@"Lato-Regular" size:11.5]];
    [listViewCell.txtLocation setFont:[UIFont fontWithName:@"Lato-Regular" size:13]];

    
    
    //text information related to list object
    listViewCell.txtCaption.text  = [object objectForKey:@"caption"];
    listViewCell.txtLocation.text = [object objectForKey:@"location"];
    listViewCell.txtType.text     = [NSString stringWithFormat:@"tagged as: %@",[object objectForKey:@"type"]];
    
  
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [df stringFromDate:object.createdAt];
    listViewCell.txtTime.text = [ViewHelper fuzzyTime:date];
   
    
    PFObject *user = [object objectForKey:@"postedBy"];
    
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        listViewCell.txtUsername.text = [user objectForKey:@"username"];
        
    }];
    
    return cell;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NextPage";
    
    UITableViewCell *cell;
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"CellLocationView" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detail = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    //UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:detail];
     [self.navigationController pushViewController:detail animated:YES];
    
    
    UIButton *logo = [[UIButton alloc] initWithFrame:CGRectMake(0, -20, 40, 39)];
    [logo setImage:[UIImage imageNamed:@"navi_logo.png"] forState:UIControlStateNormal];
    UIBarButtonItem *logoRight = [[UIBarButtonItem alloc] initWithCustomView:logo];
    
    self.navigationController.navigationItem.rightBarButtonItem = logoRight;

    
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    
    //add values from parse backend
    [detail.txtCaption setFont:[UIFont fontWithName:@"Lato-Light" size:28]];
    [detail.txtTimeStamp setFont:[UIFont fontWithName:@"Lato-Regular" size:9]];
    [detail.txtUsername setFont:[UIFont fontWithName:@"Lato-Regular" size:11.5]];
    [detail.txtType setFont:[UIFont fontWithName:@"Lato-Regular" size:11.5]];
    [detail.txtLocation setFont:[UIFont fontWithName:@"Lato-Regular" size:13]];
    
    
    //text information related to list object
    detail.txtCaption.text  = [object objectForKey:@"caption"];
    detail.txtLocation.text = [object objectForKey:@"location"];
    detail.txtType.text     = [NSString stringWithFormat:@"tagged as: %@",[object objectForKey:@"type"]];
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [df stringFromDate:object.createdAt];
    detail.txtTimeStamp.text = [ViewHelper fuzzyTime:date];
    
    
    PFObject *user = [object objectForKey:@"postedBy"];
    
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
        detail.txtUsername.text = [user objectForKey:@"username"];
        
    }];

    
    PFFile *thumb = [object objectForKey:@"file"];
    [thumb getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            
            // image can now be set on a UIImageView
            detail.imgDetail.image = [UIImage imageWithData:data];
            
            //animate the logo and the intro text
            [UIView animateWithDuration:0.5
                                  delay:1.0
                                options: UIViewAnimationCurveEaseOut
                             animations:^{
                                 
                                 [detail.imgDetail setAlpha:1.0f];
                                 
                             }
                            completion:nil];
                           }
                        }];
                      }



//enable table editing
/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 131;
    
}*/


@end
