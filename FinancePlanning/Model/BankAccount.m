//
//  BankAccount.m
//  FinancePlanning
//
//  Created by Anil Saini on 02/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount
@synthesize balance;

- (void)setBalance:(float)newBalance
{
    balance += newBalance;
}

@end
