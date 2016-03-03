//
//  DBManager.h
//  FinancePlanning
//
//  Created by Anil Saini on 3/3/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

@property(nonatomic, strong) NSString *databasePath;

+ (DBManager*)sharedDatabaseManager;
- (BOOL)createDatabase;


@end
