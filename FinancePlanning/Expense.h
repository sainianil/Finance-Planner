//
//  Expense.h
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface Expense : NSObject
{
    Event *event;
}
@property(nonatomic, strong) Event *event;

- (void)updateExpense;

@end
