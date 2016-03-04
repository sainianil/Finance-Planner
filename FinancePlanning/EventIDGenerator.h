//
//  EventIDGenerator.h
//  FinancePlanning
//
//  Created by Anil Saini on 04/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventIDGenerator : NSObject
//Generate unique id with income/expense + timestamp
+ (NSString*)generateUniqueEventID:(EventCategory)eventCat;
@end
