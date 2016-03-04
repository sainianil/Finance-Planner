//
//  Income.h
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"


@interface Income : NSObject
{
    Event *event;
}

@property(nonatomic, strong) Event *event;

- (BOOL)updateIncome;

@end
