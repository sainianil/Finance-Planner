//
//  DBManager.m
//  FinancePlanning
//
//  Created by Anil Saini on 3/3/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "DBManager.h"
#import "sqlite3.h"

static DBManager *sharedDBManager = nil;

@interface DBManager()
{
    sqlite3 *database;
    sqlite3_stmt *statement;
}
@end

@implementation DBManager
@synthesize databasePath;

- (void)dealloc {
    sharedDBManager = nil;
    databasePath = nil;
    database = nil;
    statement = nil;
}

+ (DBManager*)sharedDatabaseManager {
    if (!sharedDBManager) {
        sharedDBManager = [[DBManager allocWithZone:NULL] init];
        [sharedDBManager createDatabase];
    }
    
    return sharedDBManager;
}

- (BOOL)createDatabase {
    return YES;
}
@end
