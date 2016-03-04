//
//  Expense.m
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "Expense.h"
#import "EventIDGenerator.h"
#import "DBManager.h"
#import "MyUtilities.h"

@implementation Expense
@synthesize event;

- (instancetype)init {
    if (self = [super init]) {
        self.event = [[Event alloc] initWithEventCategory:eExpense];
    }
    return self;
}

- (BOOL)updateExpense {
    BOOL isExpenseAdded = NO;
    
    self.event.eventID = [EventIDGenerator generateUniqueEventID:eExpense];
    isExpenseAdded = [[DBManager sharedDatabaseManager] createEvent:event];
    
    int months = 1;
    if (event.eventType == eRecurring) {
        if ([event.recurringByDuration isEqualToString:@"Quarterly"]) {
            months = 3;
        }
        
        for (int i = 1; i < [event.occurrences integerValue]; i++) {
            event.eventID = [[EventIDGenerator generateUniqueEventID:eExpense] stringByAppendingFormat:@"-%d", i];
            event.startDate = [MyUtilities date:event.startDate increaseDateByMonth:months];
            isExpenseAdded = [[DBManager sharedDatabaseManager] createEvent:event];
        }
    }
    
    return isExpenseAdded;
}
@end
