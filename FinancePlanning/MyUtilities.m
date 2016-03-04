//
//  MyUtilities.m
//  FinancePlanning
//
//  Created by Anil Saini on 04/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "MyUtilities.h"

@implementation MyUtilities

+ (UIAlertController*)alert:(NSString*)title message:(NSString*)msg button:(NSString*)btnTitle {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:actionOk];
    return alertController;
}

+ (NSDate*)date:(NSDate*)date increaseDateByMonth:(NSInteger)months {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:months];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    dateComponents = nil;
    return newDate;
}

+(BOOL)isDate:(NSDate*)date laterThanOrEqualTo:(NSDate*)newDate {
    return !([date compare:newDate] == NSOrderedAscending);
}

+(BOOL)isDate:(NSDate*)date earlierThanOrEqualTo:(NSDate*)newDate {
    return !([date compare:newDate] == NSOrderedDescending);
}
+(BOOL)isDate:(NSDate*)date laterThan:(NSDate*)newDate {
    return ([date compare:newDate] == NSOrderedDescending);
    
}
+(BOOL)isDate:(NSDate*)date earlierThan:(NSDate*)newDate {
    return ([date compare:newDate] == NSOrderedAscending);
}

+(BOOL)isDate:(NSDate*)date equalTo:(NSDate*)newDate {
    BOOL isSame = YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM"];
    
    // Sets today's date

    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *newDateStr = [dateFormatter stringFromDate:newDate];
    // if/else statement
    if (![dateString isEqualToString:newDateStr]) {
        isSame = NO;
    }
    return isSame;
}

+ (NSDate*)dateFromString:(NSString*)strDate {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSDate *myDate = [df dateFromString: strDate];
    return myDate;
}

+ (NSString*)stringFromDate:(NSDate*)date {
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    return dateString;
}
@end
