//
//  ViewHelper.h
//  Branch
//
//  Created by Joshua Kendall on 6/12/11.
//  Copyright 2011 JoshuaKendall.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate-Utilities.h"

@interface ViewHelper : NSObject

+ (NSString *)fuzzyTime:(NSString *)datetime;

@end


//
//  ViewHelper.m
//  Branch
//
//  Created by Joshua Kendall on 6/12/11.
//  Copyright 2011 JoshuaKendall.com. All rights reserved.
//


@implementation ViewHelper

+ (NSString *)fuzzyTime:(NSString *)datetime; {
    NSString *formatted;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [formatter setTimeZone:gmt];
    NSDate *date = [formatter dateFromString:datetime];
    NSDate *today = [NSDate date];
    NSInteger minutes = [today minutesAfterDate:date];
    NSInteger hours = [today hoursAfterDate:date];
    NSInteger days = [today daysAfterDate:date];
    NSString *period;
    if(days >= 365){
        float years = round(days / 365) / 2.0f;
        period = (years > 1) ? @"yrs" : @"yr";
        formatted = [NSString stringWithFormat:@"%f%@ ago", years, period];
    } else if(days < 365 && days >= 30) {
        float months = round(days / 30) / 2.0f;
        period = (months > 1) ? @"m" : @"m";
        formatted = [NSString stringWithFormat:@" %f%@ ago", months, period];
    } else if(days < 30 && days >= 2) {
        period = @"days";
        formatted = [NSString stringWithFormat:@" %i%@ ago", days, period];
    } else if(days == 1){
        period = @"day";
        formatted = [NSString stringWithFormat:@"a %@ ago",period];
    } else if(days < 1 && minutes > 60) {
        period = (hours > 1) ? @"hrs" : @"hr";
        formatted = [NSString stringWithFormat:@"%i%@ ago", hours, period];
    } else {
        period = (minutes < 60 && minutes > 1) ? @"m" : @"m";
        formatted = [NSString stringWithFormat:@" %i%@ ago", minutes, period];
        if(minutes < 1){
            formatted = @"5s ago";
        }
    }
    return formatted;
}

@end