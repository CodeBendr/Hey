//
//  MainCell.h
//  Hey
//
//  Created by Skrizy on 7/7/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface ListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgThumb;
@property (weak, nonatomic) IBOutlet UILabel *txtCaption;


@end
