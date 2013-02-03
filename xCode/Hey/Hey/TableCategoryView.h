//
//  TableListView.h
//  Hey
//
//  Created by CodeBender on 10/29/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <Parse/Parse.h>

@interface TableCategoryView : PFQueryTableViewController <UIScrollViewDelegate>

@property (copy, nonatomic) NSString *stringCategory;

@end
