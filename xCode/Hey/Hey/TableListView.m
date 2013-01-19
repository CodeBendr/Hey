//
//  TableListView.m
//  Hey
//
//  Created by CodeBender on 10/29/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "TableListView.h"
#import "ListViewCell.h"

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
            self.objectsPerPage = 15;
        }


    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    
    if ([self.objects count] == 0) {
        
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        
    }
    
    
    
    return query;
}


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"ListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        
        UINib *nib = [UINib nibWithNibName:@"ListViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //configure cell
    ListViewCell *listViewCell = (ListViewCell*)cell;
   
    PFFile *thumb = [object objectForKey:@"thumbnail"];
    [thumb getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
           
             listViewCell.imgThumb.image = [UIImage imageWithData:data];
            // image can now be set on a UIImageView
        }
    }];
    
    
    //text information related to list object
    listViewCell.txtCaption.text = [object objectForKey:@"caption"];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



//enable table editing
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 131;
    
}


@end
