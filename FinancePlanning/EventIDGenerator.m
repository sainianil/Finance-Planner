//
//  EventIDGenerator.m
//  FinancePlanning
//
//  Created by Anil Saini on 04/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "EventIDGenerator.h"

@implementation EventIDGenerator

+ (NSString*)generateUniqueEventID:(EventCategory)eventCat {
    NSString *uniqueEventID = nil;
    if (eventCat == eIncome) {
        uniqueEventID = @"Income-";
    } else if (eventCat == eExpense) {
        uniqueEventID = @"Expense-";
    }
    uniqueEventID = [uniqueEventID stringByAppendingFormat:@"%@", [EventIDGenerator timeStamp]];
    return uniqueEventID;
}

+ (NSNumber*)timeStamp {
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithInteger:timeStamp];
    return timeStampObj;
}
@end
