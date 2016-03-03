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
}

- (BOOL)createDatabase;
- (BOOL)openDB;
- (BOOL)executeQuery:(NSString*)query;
- (BOOL)insertAccountBalance;
- (NSMutableArray *)runSelecteQueryForColumns:(NSArray*)columns ontableName: (NSString*)tableName withWhereClause:(NSString *)whereClause withOrderByClause:(NSString*)orederByCalause withGroupByClause:(NSString*)groupByClause;
@end

@implementation DBManager
@synthesize databasePath;

- (void)dealloc {
    sharedDBManager = nil;
    databasePath = nil;
    //cloase database
    if (database) {
        sqlite3_close(database);
    }
    database = nil;
}

+ (DBManager*)sharedDatabaseManager {
    //Create DBManager singleton object
    if (!sharedDBManager) {
        sharedDBManager = [[DBManager allocWithZone:NULL] init];
        [sharedDBManager createDatabase];
    }
    
    return sharedDBManager;
}

- (BOOL)openDB {
    BOOL isOpen = NO;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        isOpen = YES;
    }
    
    return isOpen;
}

- (BOOL)createDatabase {
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    //Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"financeplan.db"]];
    NSLog(@"dbPath: %@", databasePath);
    BOOL isDBCreated = YES;
    
    //Check whether file is already exists
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if ([fileMgr fileExistsAtPath:databasePath] == NO) {
        if ([self openDB]) {
            char *errMsg;
            
            /* 
             BankAccount
             -----------
             accountID
             float balance;
             */
            const char *sqlStmt = "create table if not exists BankAccount (accountID integer primary key, balance real)";
            
            if (sqlite3_exec(database, sqlStmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isDBCreated = NO;
                NSLog(@"ERR: Failed to create BankAccount table![ERR: %s]", errMsg);
            }
            
            if(![[DBManager sharedDatabaseManager] insertAccountBalance]) {
                NSLog(@"ERR: Failed to insert account balance!");
            }
            /*
             Event table
             -----------
             EventID
             EventCategory eventCategory;
             EventType eventType;
             NSString *eventName;
             NSNumber *amount;
             NSString *eventDescription;
             NSDate *startDate;
             NSString *recurringByDuration;
             NSNumber *occurrences;
             */
            
            sqlStmt = "create table if not exists Event (eventID integer primary key, category integer, type integer, name text, amount real, desc text, startDate text, duration text, occurrences integer)";
            
            if (sqlite3_exec(database, sqlStmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                isDBCreated = NO;
                NSLog(@"Failed to create Event table![ERR: %s]", errMsg);
            }
            
            sqlite3_close(database);
        } else {
            isDBCreated = NO;
            NSLog(@"Failed to open database!");
        }
    }
    return isDBCreated;
}

- (BOOL)executeQuery:(NSString*)query {
    
    BOOL isInserted = NO;

    if ([self openDB])
    {
        sqlite3_stmt *statement = nil;
        const char *insert_stmt = [query UTF8String];
        sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            isInserted = YES;
        }
        
        sqlite3_reset(statement);
        sqlite3_close(database);
        
    } else {
        NSLog(@"Failed to open database!");
    }
    
    return isInserted;
}

- (BOOL)insertAccountBalance {
    NSString *insertSQL = [NSString stringWithFormat:@"insert into BankAccount (accountID, balance) values (\"%d\",\"%0.2f\")", 111, 0.0];
    
    return [self executeQuery:insertSQL];
}

- (NSMutableArray *)runSelecteQueryForColumns:(NSArray*)columns ontableName: (NSString*)tableName withWhereClause:(NSString *)whereClause withOrderByClause:(NSString*)orederByCalause withGroupByClause:(NSString*)groupByClause
{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    if(!database && ![self openDB])
    {
        sqlite3_close(database);
        NSLog(@"ERR: failed to open db!");
        return nil;
    }
    
    NSMutableString *simpleQuery =[[NSMutableString alloc] initWithString:@"Select"] ;
    
    if(columns)
    {
        for(int row = 0 ; row < [columns count] ; row++)
        {
            if(row != [columns count]-1)
            {
                [simpleQuery appendString:[NSString stringWithFormat:@" %@,", [columns objectAtIndex:row]]];
            }
            else
            {
                [simpleQuery appendString:[NSString stringWithFormat:@" %@", [columns objectAtIndex:row]]];
            }
        }
    }
    else
    {
        [simpleQuery appendString:@" *"];
    }
    
    [simpleQuery appendString:[NSString stringWithFormat:@" From %@", tableName]];
    
    if(whereClause)
    {
        [simpleQuery appendString:[NSString stringWithFormat:@" %@", whereClause]];
    }
    
    if(groupByClause)
    {
        [simpleQuery appendString:[NSString stringWithFormat:@" %@", groupByClause]];
    }
    
    if(orederByCalause)
    {
        [simpleQuery appendString:[NSString stringWithFormat:@" %@", orederByCalause]];
    }
    
    NSLog(@"Select Query: - %@",simpleQuery);
    
    const char *query_stmt = [simpleQuery UTF8String];
    
    sqlite3_stmt *statement = nil;
    
    int i = sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL);
    
    if (i == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            [resultArray addObject:[self createDictionary:statement]];
        }
    }
    else
    {
        resultArray = nil;
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    NSLog(@"RESULT %@", resultArray);
    
    return resultArray;
}

- (NSDictionary*)createDictionary:(sqlite3_stmt*)statement {
    
    NSMutableDictionary *itemDic = [[NSMutableDictionary alloc] init];
    int columns = sqlite3_column_count(statement);
    for (int i=0; i<columns; i++) {
        char *name = (char *)sqlite3_column_name(statement, i);
        NSString *key = [NSString stringWithUTF8String:name];
        switch (sqlite3_column_type(statement, i)) {
            case SQLITE_INTEGER:{
                int num = sqlite3_column_int(statement, i);
                [itemDic setValue:[NSNumber numberWithInt:num] forKey:key];
            }
                break;
            case SQLITE_FLOAT:{
                float num = sqlite3_column_double(statement, i);
                [itemDic setValue:[NSNumber numberWithFloat:num] forKey:key];
            }
                break;
            case SQLITE3_TEXT:{
                char *text = (char *)sqlite3_column_text(statement, i);
                [itemDic setValue:[NSString stringWithUTF8String:text] forKey:key];
            }
                break;
            case SQLITE_BLOB:{
                //Need to implement
                [itemDic setValue:@"binary" forKey:key];
            }
                break;
            case SQLITE_NULL:{
                [itemDic setValue:[NSNull null] forKey:key];
            }
            default:
                break;
        }
    }
    
    return itemDic;
}

- (float)accountBalance {
    float balance = 0.0;
    NSMutableArray *result = [self runSelecteQueryForColumns:@[@"balance"] ontableName:@"BankAccount" withWhereClause:@"where accountID = 111" withOrderByClause:nil withGroupByClause:nil];
    balance = [[[result objectAtIndex:0] valueForKey:@"balance"] floatValue];
    return balance;
}
    
- (BOOL)updateAccountBalance:(float)balance {
    NSString *query = [NSString stringWithFormat:@"UPDATE BankAccount SET balance = %0.2f                       WHERE accountID = 111", balance];
    return [self executeQuery:query];
}

@end
