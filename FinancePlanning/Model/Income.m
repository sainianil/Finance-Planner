//
//  Income.m
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "Income.h"
#import "DBManager.h"
#import "EventIDGenerator.h"
#import "MyUtilities.h"

@implementation Income
@synthesize event;

- (instancetype)init {
    if (self = [super init]) {
        self.event = [[Event alloc] initWithEventCategory:eIncome];
    }
    return self;
}

- (BOOL)updateIncome {
    BOOL isIncomeAdded = NO;
    
    self.event.eventID = [EventIDGenerator generateUniqueEventID:eIncome];
    
    isIncomeAdded = [[DBManager sharedDatabaseManager] createEvent:event];
    
    int months = 1;
    if (event.eventType == eRecurring) {
        if ([event.recurringByDuration isEqualToString:@"Quarterly"]) {
            months = 3;
        }
        
        for (int i = 1; i < [event.occurrences integerValue]; i++) {
            event.eventID = [[EventIDGenerator generateUniqueEventID:eIncome] stringByAppendingFormat:@"-%d", i];
            event.startDate = [MyUtilities date:event.startDate increaseDateByMonth:months];
            isIncomeAdded = [[DBManager sharedDatabaseManager] createEvent:event];
        }
    }
    
    return isIncomeAdded;
}
@end
