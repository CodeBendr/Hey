//
//  NSString+Manipulation.m
//  Hey
//
//  Created by CodeBender on 2/3/13.
//  Copyright (c) 2013 Digital Benders. All rights reserved.
//

#import "NSString+Manipulation.h"

@implementation NSString (Manipulation)

-(NSString*)getFirstCharacterFromString:(NSString *)character{

    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray * words = [character componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    for (NSString * word in words) {
        
        if ([word length] > 0) {
            NSString * firstLetter = [word substringWithRange:[word rangeOfComposedCharacterSequenceAtIndex:0]];
            [firstCharacters appendString:[firstLetter uppercaseString]];
        }
    }
    
    return firstCharacters;

}

@end
