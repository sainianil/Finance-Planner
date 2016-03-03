//
//  Expense.m
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "Expense.h"

@implementation Expense
@synthesize event;

- (instancetype)init {
    if (self = [super init]) {
        self.event = [[Event alloc] initWithEventCategory:eExpense];
    }
    return self;
}

- (void)updateExpense {
    NSLog(@"%@", event);
}
@end
