//
//  MyUtilities.h
//  FinancePlanning
//
//  Created by Anil Saini on 04/03/16.
//  Copyright © 2016 Anil Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyUtilities : NSObject
+ (UIAlertController*)alert:(NSString*)title message:(NSString*)msg button:(NSString*)btnTitle;
+ (NSDate*)date:(NSDate*)date increaseDateByMonth:(NSInteger)months;
+(BOOL)isDate:(NSDate*)date laterThanOrEqualTo:(NSDate*)newDate;
+(BOOL)isDate:(NSDate*)date earlierThanOrEqualTo:(NSDate*)newDate;
+(BOOL)isDate:(NSDate*)date laterThan:(NSDate*)newDate;
+(BOOL)isDate:(NSDate*)date earlierThan:(NSDate*)newDate;
+(BOOL)isDate:(NSDate*)date equalTo:(NSDate*)newDate;
+ (NSDate*)dateFromString:(NSString*)strDate;
+ (NSString*)stringFromDate:(NSDate*)date;
@end
