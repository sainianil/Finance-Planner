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
@property (nonatomic, assign) EventCategory eventCategory;

@end

@implementation Event

- (instancetype)init {
    if (self = [super init]) {
        self.eventCategory = eIncome;
    }
    return self;
}

- (Event*)initWithEventCategory:(EventCategory)eventCat {
    if(self = [self init]) {
        self.eventCategory = eventCat;
    }
    return self;
}

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"Event:(\n Type: %d (Ad-hoc = 0, Recurring = 1),\n Category:%d (Monthly = 0, Quarterly = 1),\n Name:%@,\n Desc: %@,\n StartDate:%@)", eventType, eventCategory, eventName, eventDescription, startDate];
    
    if (eventType == eRecurring) {
        desc = [NSString stringWithFormat:@"Event:(\n Type: %d (Ad-hoc = 0, Recurring = 1),\n Category:%d (Monthly = 0, Quarterly = 1),\n Name:%@,\n Desc: %@,\n StartDate:%@,\n RecurringByDuration:%@,\n Occurrences:%@)", eventType, eventCategory, eventName, eventDescription, startDate, recurringByDuration, occurrences];
    }
    
    return desc;
}

@synthesize eventType;
@synthesize eventCategory;
@synthesize eventName;
@synthesize eventDescription;
@synthesize startDate;
@synthesize recurringByDuration;
@synthesize occurrences;

@end
