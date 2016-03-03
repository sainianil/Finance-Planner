//
//  Income.m
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "Income.h"

@implementation Income
@synthesize event;

- (instancetype)init {
    if (self = [super init]) {
        self.event = [[Event alloc] initWithEventCategory:eIncome];
    }
    return self;
}

- (void)updateIncome {
    NSLog(@"%@", event);
}
@end
