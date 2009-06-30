//
//  ExpenseDAO.m
//  expenses
//
//  Created by Kevin Edwards on 15/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ExpenseDAO.h"
#import "SQLiteAccess.h"
#import "Arithmetic.h"
#import "DateManipulator.h"

@implementation ExpenseDAO

+ (void)deleteExpense:(int)expense_id {
	
	NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM expenses WHERE expense_id = %d", expense_id];
	
	return [SQLiteAccess deleteWithSQL:sqlString];
}

+ (int) expensesCount {
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:@"SELECT expense_id FROM expenses"];
	return [sqlObjects count];
}

+ (NSArray *)fetchExpenses {
	
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM expenses ORDER BY created_at DESC"];	
	return [ExpenseDAO expenseObjectsFromSQLObjects:sqlObjects];
}

+ (NSArray *)fetchNecessaryExpenses {
	return [SQLiteAccess selectManyValuesWithSQL:@"SELECT expense_name FROM expenses WHERE expense_necessary = 1"];
}

+ (NSArray *)fetchUnnecessaryExpenses {
	return [SQLiteAccess selectManyValuesWithSQL:@"SELECT expense_name FROM expenses WHERE expense_necessary = 0"];
}

+ (NSArray *)fetchNecessaryExpenseCosts {
	return [SQLiteAccess selectManyValuesWithSQL:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 1"];
}

+ (NSArray *)fetchUnnecessaryExpenseCosts {
	return [SQLiteAccess selectManyValuesWithSQL:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 0"];
}

+ (float) totalExpenseCosts {	
	return [Arithmetic floatArraySummer:[ExpenseDAO fetchNecessaryExpenseCosts]] + [Arithmetic floatArraySummer:[ExpenseDAO fetchUnnecessaryExpenseCosts]];
}

+ (float) totalNecessaryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchNecessaryExpenseCosts];
	return [Arithmetic floatArraySummer:expenses];	
}

+ (float) totalLuxuryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchUnnecessaryExpenseCosts];
	return [Arithmetic floatArraySummer:expenses];	
}

+ (float) lastWeeksTotalNecessaryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchLastWeeksNecessaryExpenseCosts];
	return [Arithmetic floatArraySummer:expenses];	
}

+ (float) lastWeeksTotalLuxuryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchLastWeeksLuxuryExpenseCosts];
	return [Arithmetic floatArraySummer:expenses];	
}

+ (float) lastMonthsTotalNecessaryExpenseCosts {
	NSArray *expenses = [ExpenseDAO fetchLastMonthsNecessaryExpenseCosts];
	return [Arithmetic floatArraySummer:expenses];
}

+ (float) lastMonthsTotalLuxuryExpenseCosts {
	NSArray *expenses = [ExpenseDAO fetchLastMonthsLuxuryExpenseCosts];
	return [Arithmetic floatArraySummer:expenses];	
}


+ (float)percentageNecessary {
	
	float totalNecessaryExpenseCosts = [ExpenseDAO totalNecessaryExpenseCosts];
	float totalLuxuryExpenseCosts = [ExpenseDAO totalLuxuryExpenseCosts];
	
	//NSLog(@"Total necessary expenses: %f", totalNecessaryExpenseCosts);
	//NSLog(@"Total luxury expenses: %f", totalLuxuryExpenseCosts);
	
	float totalExpenses = totalNecessaryExpenseCosts + totalLuxuryExpenseCosts;
	
	//NSLog(@"Total expenses: %f", totalExpenses);
	
	return (totalNecessaryExpenseCosts / totalExpenses) * 100;
	
}



+ (NSArray *)fetchLastWeeksNecessaryExpenseCosts {
	
	// sqlite3 date format should conform to: 2009-04-20 08:22:53

	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aWeekAgo = [today addTimeInterval: -7 * 24 * 60 * 60];
	
	NSString *weekAgoString = [DateManipulator sqliteDateTimeString:aWeekAgo];	
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 1 AND created_at >= '%@'", weekAgoString];

	
	return [SQLiteAccess selectManyValuesWithSQL:queryString];
}

+ (NSArray *)fetchLastWeeksLuxuryExpenseCosts {
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aWeekAgo = [today addTimeInterval: -7 * 24 * 60 * 60];
	
	NSString *weekAgoString = [DateManipulator sqliteDateTimeString:aWeekAgo];
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 0 AND created_at >= '%@'", weekAgoString];
	
	return [SQLiteAccess selectManyValuesWithSQL:queryString];
}

+ (float) lastWeeksPercentageNecessary {
	float totalNecessaryExpenseCosts = [ExpenseDAO lastWeeksTotalNecessaryExpenseCosts];
	float totalLuxuryExpenseCosts = [ExpenseDAO lastWeeksTotalLuxuryExpenseCosts];

	
	float totalExpenses = totalNecessaryExpenseCosts + totalLuxuryExpenseCosts;
	
	
	return (totalNecessaryExpenseCosts / totalExpenses) * 100;
}

// TODO refactor this unDRY date formatter init stuff and also mem management needs handling
+ (NSArray *)fetchLastMonthsNecessaryExpenseCosts {
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aMonthAgo = [today addTimeInterval: -30 * 24 * 60 * 60];
	
	NSString *aMonthAgoString = [DateManipulator sqliteDateTimeString:aMonthAgo];
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 1 AND created_at >= '%@'", aMonthAgoString];

	return [SQLiteAccess selectManyValuesWithSQL:queryString];
	
}

+ (NSArray *)fetchLastMonthsLuxuryExpenseCosts {
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aMonthAgo = [today addTimeInterval: -30 * 24 * 60 * 60];
	
	NSString *aMonthAgoString = [DateManipulator sqliteDateTimeString:aMonthAgo];
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 0 AND created_at >= '%@'", aMonthAgoString];
	
	return [SQLiteAccess selectManyValuesWithSQL:queryString];
}

+ (float) lastMonthsPercentageNecessary {
	float totalNecessaryExpenseCosts = [ExpenseDAO lastMonthsTotalNecessaryExpenseCosts];
	float totalLuxuryExpenseCosts = [ExpenseDAO lastMonthsTotalLuxuryExpenseCosts];
	
	NSLog(@"Total necessary expenses: %f", totalNecessaryExpenseCosts);
	NSLog(@"Total luxury expenses: %f", totalLuxuryExpenseCosts);
	
	float totalExpenses = totalNecessaryExpenseCosts + totalLuxuryExpenseCosts;
	
	NSLog(@"Total expenses: %f", totalExpenses);
	
	return (totalNecessaryExpenseCosts / totalExpenses) * 100;
}

+ (Expense *)lastExpenseEntered {
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM expenses ORDER BY created_at DESC LIMIT 1"];
	return [ExpenseDAO expenseObjectFromSQLObjects:sqlObjects];
}

// Work out the percentage change from the last expense
// Get the total cost of all expenses
// Get the old total
// Work out percentage of old total that last expense equals

// e.g. Old total is 20 - last expense is 5
// Percentage change = (5/20) * 100 = 25% change
+ (NSString *)lastExpensePercentageChange {
	
	Expense *lastExpense = [ExpenseDAO lastExpenseEntered];
	
	float currentTotal = [self totalExpenseCosts];
	float oldTotal = currentTotal - [lastExpense cost];
	
	float percentageChange = 0;
	//prevent divide by zero
	if(oldTotal == 0) {
		percentageChange = 100;
	}
	else {
		percentageChange = ([lastExpense cost] / oldTotal) * 100;
	}
	
	NSString *percentageChangeString;
	
	if(percentageChange < 100)
	{
		float roundedValue = round(2.0f * percentageChange) / 2.0f;
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setMaximumFractionDigits:2];
		[formatter setRoundingMode: NSNumberFormatterRoundUp];
	
		NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
		[formatter release];
		percentageChangeString = [NSString stringWithFormat:@"+ %@%%", numberString];
	}
	else {
		percentageChangeString = @"+ 100%";
	}
	
	
	
	
	return percentageChangeString;
	
}


// calculates the percentage of luxury costs within a 24 hour period
//+ (float) luxuryPercentageOnThisDay:(NSDate *)date {
//	
//	
//
//	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 0 AND created_at >= '%@' AND created_at <= '%@'", startDateString, endDateString];
//	
//		
//	
//	return 0.0;
//}

+ (NSArray *) luxuryExpensesForDay:(NSDate *)date {
	
	NSDate *twentyFourHoursBefore = [date addTimeInterval: -24 * 60 * 60];
	
	NSString *startDateString = [DateManipulator sqliteDateTimeString:twentyFourHoursBefore];
	NSString *endDateString = [DateManipulator sqliteDateTimeString:date];
	
	NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM expenses WHERE expense_necessary = 0 AND created_at >= '%@' AND created_at <= '%@'", startDateString, endDateString];
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:queryString];
	
	return [ExpenseDAO expenseObjectsFromSQLObjects:sqlObjects];
	
}

+ (NSArray *) necessaryExpensesForDay:(NSDate *)date {

	NSDate *twentyFourHoursBefore = [date addTimeInterval: -24 * 60 * 60];

	NSString *startDateString = [DateManipulator sqliteDateTimeString:twentyFourHoursBefore];
	NSString *endDateString = [DateManipulator sqliteDateTimeString:date];
	
	NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM expenses WHERE expense_necessary = 1 AND created_at >= '%@' AND created_at <= '%@'", startDateString, endDateString];
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:queryString];
	
	return [ExpenseDAO expenseObjectsFromSQLObjects:sqlObjects];
	
}

+ (NSArray *) expensesForDay:(NSDate *)date {
	
	NSDate *twentyFourHoursBefore = [date addTimeInterval: -24 * 60 * 60];
	
	NSString *startDateString = [DateManipulator sqliteDateTimeString:twentyFourHoursBefore];
	NSString *endDateString = [DateManipulator sqliteDateTimeString:date];
	
	NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM expenses WHERE created_at >= '%@' AND created_at <= '%@'", startDateString, endDateString];
	NSLog(@"Query string: %@", queryString);
	
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:queryString];
	
	return [ExpenseDAO expenseObjectsFromSQLObjects:sqlObjects];
	
}

+ (float) luxuryPercentageForDay:(NSDate *)date {
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	//[dateFormatter setDateFormat:@"%Y-%m-%d %H:%M"];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];

	
	NSArray *expenses = [ExpenseDAO expensesForDay:date];
	
	NSLog(@"Total number of expenses on day %@ : %d", [dateFormatter stringFromDate:date], [expenses count]);
	
	float totalLuxuryCost = 0.0;
	float totalCost = 0.0;
	
	Expense *tempExpense = [Expense alloc];
	
	for(int i=0; i<[expenses count]; i++) {
		
		tempExpense = [expenses objectAtIndex:i];
		
		totalCost  += [tempExpense cost];
		
		if(tempExpense.necessary == NO) {
			totalLuxuryCost  += [tempExpense cost];
		}
		
	}
	
	[tempExpense release];

	NSLog(@"Total luxury cost: %f", totalLuxuryCost);
	NSLog(@"Total cost: %f", totalCost);
	
	
	if(totalCost == 0) {
		return 0;
	}
	
	return (totalLuxuryCost / totalCost) * 100.0;
	
}


+ (NSDateFormatter *) dateFormatter {
	// sqlite3 date format should conform to: 2009-04-20 08:22:53
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"%Y-%m-%d %H:%M"];

	return dateFormatter;

}

// converts sql objects from a query into an array of Expense objects
+ (NSArray *) expenseObjectsFromSQLObjects:(NSArray *)sqlObjects {
	
	NSMutableArray *expenses = [NSMutableArray arrayWithCapacity:[sqlObjects count]];

			
	for(int i=0; i< [sqlObjects count]; i++) {
		
		Expense *expense = [Expense alloc];
		NSDictionary *row = [sqlObjects objectAtIndex:i];
		
		expense.name = [row objectForKey:@"expense_name"];
		expense.expense_id = [[row objectForKey:@"expense_id"] intValue];
		expense.necessary = [[row objectForKey:@"expense_necessary"] boolValue];
		expense.cost = [[row objectForKey:@"expense_cost"] floatValue];
		
		[expenses addObject:expense];
		
		[expense release];
		
	}

	return expenses;
}

// converts sql objects from a query into an Expense object
+ (Expense *) expenseObjectFromSQLObjects:(NSArray *)sqlObjects {
	if([sqlObjects count] > 0) {
		Expense *expense = [Expense alloc];
		
		NSDictionary *row = [sqlObjects objectAtIndex:0];
		
		expense.name = [row objectForKey:@"expense_name"];
		expense.expense_id = [[row objectForKey:@"expense_id"] intValue];
		expense.necessary = [[row objectForKey:@"expense_necessary"] boolValue];
		expense.cost = [[row objectForKey:@"expense_cost"] floatValue];
		
		//NSLog(@"LAST NECESSARY:)
		
		return expense;
	}
	else {
		return NULL;
	}
}

@end

