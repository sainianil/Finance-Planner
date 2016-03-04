//
//  DBManager.h
//  FinancePlanning
//
//  Created by Anil Saini on 3/3/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface DBManager : NSObject
{
    NSString *databasePath;
}

@property(nonatomic, strong) NSString *databasePath;

//Singleton class object
+ (DBManager*)sharedDatabaseManager;

//moved as private method because we'll create database as soon as DBManager's object is created
//- (BOOL)createDatabase;

//Return's account balance from db
- (float)accountBalance;
//Update balance with new balance
- (BOOL)updateAccountBalance:(float)balance;
//Create event Ad-hoc and Recurring
- (BOOL)createEvent:(Event*)event;

- (NSArray*)allIncomes;
- (NSArray*)allExpenses;
@end
