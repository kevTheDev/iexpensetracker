//
//  ExpenseDAO.h
//  expenses
//
//  Created by Kevin Edwards on 15/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expense.h"

@interface ExpenseDAO : NSObject {
	
}

+ (int) expensesCount;
+ (void)deleteExpense:(int)expense_id;
+ (NSArray *)fetchExpenses;
+ (NSArray *)fetchNecessaryExpenses;
+ (NSArray *)fetchUnnecessaryExpenses;
+ (NSArray *)fetchNecessaryExpenseCosts;
+ (NSArray *)fetchUnnecessaryExpenseCosts;

+ (float) totalExpenseCosts;
+ (float) totalNecessaryExpenseCosts;
+ (float) totalLuxuryExpenseCosts;

+ (float) percentageNecessary;


+ (float) lastWeeksTotalNecessaryExpenseCosts;
+ (float) lastWeeksTotalLuxuryExpenseCosts;	
+ (NSArray *)fetchLastWeeksNecessaryExpenseCosts;
+ (NSArray *)fetchLastWeeksLuxuryExpenseCosts;
+ (float) lastWeeksPercentageNecessary;

+ (float) lastMonthsTotalNecessaryExpenseCosts;
+ (float) lastMonthsTotalLuxuryExpenseCosts;
+ (NSArray *)fetchLastMonthsNecessaryExpenseCosts;
+ (NSArray *)fetchLastMonthsLuxuryExpenseCosts;
+ (float) lastMonthsPercentageNecessary;

+ (Expense *)lastExpenseEntered;
+ (NSString *)lastExpensePercentageChange;

 
+ (NSArray *) luxuryExpensesForDay:(NSDate *)date;
+ (NSArray *) necessaryExpensesForDay:(NSDate *)date;
+ (NSArray *) expensesForDay:(NSDate *)date;

//+ (float) totalLuxuryExpenseCostsForDate:(NSDate *)date;
//+ (float) totalNecessaryExpenseCostsForDate:(NSDate *)date;
//+ (float) totalExpenseCostsForDate:(NSDate *)date;

//+ (float) luxuryPercentageOnThisDate(NSDate *);
//+ (float) necessaryPercentageOnThisDate(NSDate *);

+ (NSDateFormatter *) dateFormatter;

+ (NSArray *) expenseObjectsFromSQLObjects:(NSArray *)sqlObjects;
+ (Expense *) expenseObjectFromSQLObjects:(NSArray *)sqlObjects;


@end
