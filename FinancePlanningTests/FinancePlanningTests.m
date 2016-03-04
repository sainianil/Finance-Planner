//
//  FinancePlanningTests.m
//  FinancePlanningTests
//
//  Created by Anil Saini on 3/2/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BankAccount.h"
#import "Income.h"
#import "Expense.h"

@interface FinancePlanningTests : XCTestCase

@end

@implementation FinancePlanningTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testUpdateAccountBalance {
    float bal = 100.0;
    [[BankAccount sharedBankAccount] setBalance:bal];
    XCTAssertEqual(bal, [[BankAccount sharedBankAccount] balance]);
    
    bal = 50;
    [[BankAccount sharedBankAccount] setBalance:bal];
    bal+=100;
    XCTAssertEqual(bal, [[BankAccount sharedBankAccount] balance]);
}

- (void)testCreateAdHocIncome {
    Income *income = [[Income alloc] init];
    EventType eType = eAd_hoc;
    [[income event] setEventType:eType];
    NSString *name = @"Loan";
    [[income event] setEventName:name];
    NSNumber *amt = [NSNumber numberWithFloat:100.0];
    [[income event] setAmount:amt];
    NSString *desc = @"Loan";
    [[income event] setEventDescription:desc];
    NSDate *date = [NSDate date];
    [[income event] setStartDate:date];
    
    XCTAssertEqual([[income event] eventType], eType);
    XCTAssertEqual([[income event] eventName], name);
    XCTAssertEqual([[income event] amount], amt);
    XCTAssertEqual([[income event] eventDescription], desc);
    XCTAssertEqual([[income event] startDate], date);
    
}

- (void)testCreateRecurringIncome {
    Income *income = [[Income alloc] init];
    EventType eType = eAd_hoc;
    [[income event] setEventType:eType];
    NSString *name = @"Loan";
    [[income event] setEventName:name];
    NSNumber *amt = [NSNumber numberWithFloat:100.0];
    [[income event] setAmount:amt];
    NSString *desc = @"Loan";
    [[income event] setEventDescription:desc];
    NSDate *date = [NSDate date];
    [[income event] setStartDate:date];
    NSString *duration = @"Monthly";
    [[income event] setRecurringByDuration:duration];
    NSNumber *ocr = [NSNumber numberWithInteger:12];
    [[income event] setOccurrences:ocr];
    
    XCTAssertEqual([[income event] eventType], eType);
    XCTAssertEqual([[income event] eventName], name);
    XCTAssertEqual([[income event] amount], amt);
    XCTAssertEqual([[income event] eventDescription], desc);
    XCTAssertEqual([[income event] startDate], date);
    XCTAssertEqual([[income event] recurringByDuration], duration);
    XCTAssertEqual([[income event] occurrences], ocr);
}

- (void)testCreateAdHocExpense {
    Expense *expense = [[Expense alloc] init];
    EventType eType = eAd_hoc;
    [[expense event] setEventType:eType];
    NSString *name = @"Life insurance";
    [[expense event] setEventName:name];
    NSNumber *amt = [NSNumber numberWithFloat:100.0];
    [[expense event] setAmount:amt];
    NSString *desc = @"insurance";
    [[expense event] setEventDescription:desc];
    NSDate *date = [NSDate date];
    [[expense event] setStartDate:date];
    
    XCTAssertEqual([[expense event] eventType], eType);
    XCTAssertEqual([[expense event] eventName], name);
    XCTAssertEqual([[expense event] amount], amt);
    XCTAssertEqual([[expense event] eventDescription], desc);
    XCTAssertEqual([[expense event] startDate], date);
    
}

- (void)testCreateRecurringExpense {
    Expense *expense = [[Expense alloc] init];
    EventType eType = eAd_hoc;
    [[expense event] setEventType:eType];
    NSString *name = @"Life insurance";
    [[expense event] setEventName:name];
    NSNumber *amt = [NSNumber numberWithFloat:100.0];
    [[expense event] setAmount:amt];
    NSString *desc = @"insurance";
    [[expense event] setEventDescription:desc];
    NSDate *date = [NSDate date];
    [[expense event] setStartDate:date];
    NSString *duration = @"Monthly";
    [[expense event] setRecurringByDuration:duration];
    NSNumber *ocr = [NSNumber numberWithInteger:12];
    [[expense event] setOccurrences:ocr];
    XCTAssertEqual([[expense event] eventType], eType);
    XCTAssertEqual([[expense event] eventName], name);
    XCTAssertEqual([[expense event] amount], amt);
    XCTAssertEqual([[expense event] eventDescription], desc);
    XCTAssertEqual([[expense event] startDate], date);
    XCTAssertEqual([[expense event] recurringByDuration], duration);
    XCTAssertEqual([[expense event] occurrences], ocr);
}

@end
