//
//  MainCell.m
//  Hey
//
//  Created by Skrizy on 7/7/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      //  imgThumb.layer.cornerRadius = 9.0;
      
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
