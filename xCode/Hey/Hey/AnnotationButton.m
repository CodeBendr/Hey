//
//  AnnotationButton.m
//  Hey
//
//  Created by Skrizy on 6/9/12.
//  Copyright (c) 2012 Digital Benders. All rights reserved.
//

#import "AnnotationButton.h"

@implementation AnnotationButton
@synthesize name;
@synthesize type;
@synthesize count;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
