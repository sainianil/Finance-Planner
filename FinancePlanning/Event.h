//
//  Event.h
//  FinancePlanning
//
//  Created by Anil Saini on 3/3/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum EventType {
    eAd_hoc,
    eRecurring
}EventType;

typedef enum EventCategory {
    eIncome,
    eExpense
}EventCategory;

@interface Event : NSObject
{
    EventType eventType;
    NSString *eventName;
    NSString *eventDescription;
    NSDate *startDate;
    NSString *recurringByDuration;
    NSNumber *occurrences;
    NSNumber *amount;
}

@property (nonatomic, assign) EventType eventType;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSString *recurringByDuration;
@property (nonatomic, strong) NSNumber *occurrences;
@property (nonatomic, strong) NSNumber *amount;

- (Event*)initWithEventCategory:(EventCategory)eventCat;

@end
