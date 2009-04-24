//
//  ExpenseDAO.h
//  expenses
//
//  Created by Kevin Edwards on 15/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ExpenseDAO : NSObject {
	
}

+ (NSArray *)fetchExpenses;
+ (NSArray *)fetchNecessaryExpenses;
+ (NSArray *)fetchUnnecessaryExpenses;
+ (NSArray *)fetchNecessaryExpenseCosts;
+ (NSArray *)fetchUnnecessaryExpenseCosts;
+ (float) totalNecessaryExpenseCosts;
+ (float) totalLuxuryExpenseCosts;
+ (int) percentageNecessary;
+ (NSString *)roundedNumber:(float)numberToRound;

+ (float) lastWeeksTotalNecessaryExpenseCosts;
+ (float) lastWeeksTotalLuxuryExpenseCosts;	
+ (NSArray *)fetchLastWeeksNecessaryExpenseCosts;
+ (NSArray *)fetchLastWeeksLuxuryExpenseCosts;
+ (int) lastWeeksPercentageNecessary;

+ (float) lastMonthsTotalNecessaryExpenseCosts;
+ (float) lastMonthsTotalLuxuryExpenseCosts;
+ (NSArray *)fetchLastMonthsNecessaryExpenseCosts;
+ (NSArray *)fetchLastMonthsLuxuryExpenseCosts;
+ (int) lastMonthsPercentageNecessary;

+ (float) floatArraySummer:(NSArray *)floatArray;

@end
