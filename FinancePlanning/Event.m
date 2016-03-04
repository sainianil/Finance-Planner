//
//  Event.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/3/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "Event.h"

@interface Event()
{
    EventCategory eventCategory;
}
//@property (nonatomic, assign) EventCategory eventCategory;

@end

@implementation Event
@synthesize eventID;
@synthesize eventType;
//@synthesize eventCategory;
@synthesize eventName;
@synthesize amount;
@synthesize eventDescription;
@synthesize startDate;
@synthesize recurringByDuration;
@synthesize occurrences;

- (instancetype)init {
    if (self = [super init]) {
        eventCategory = eIncome;
    }
    return self;
}

- (Event*)initWithEventCategory:(EventCategory)eventCat {
    if(self = [self init]) {
        eventCategory = eventCat;
    }
    return self;
}

- (int)eventCategory {
    return eventCategory;
}

- (NSString*)description {

       NSString *desc = [NSString stringWithFormat:@"Event:(\n EventID:%@, Type: %d (Ad-hoc = 0, Recurring = 1),\n Category:%d (Income = 0, Expense = 1),\n Name:%@,\n  Amount:%@,\n Desc: %@,\n StartDate:%@,\n RecurringByDuration:%@ (Monthly, Quarterly),\n Occurrences:%@)", eventID, eventType, eventCategory, eventName, amount, eventDescription, startDate, recurringByDuration, occurrences];
    
    return desc;
}

- (NSString*)eventDetail {
    return [NSString stringWithFormat:@"Name: %@, Description: %@, Date:%@", eventName, eventDescription, startDate];
}

@end
