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
@property (weak, nonatomic) IBOutlet UILabel *txtTime;
@property (weak, nonatomic) IBOutlet UILabel *txtUsername;
@property (weak, nonatomic) IBOutlet UILabel *txtType;
@property (weak, nonatomic) IBOutlet UILabel *txtLocation;


@end
