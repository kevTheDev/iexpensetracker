//
//  ExpenseDAO.m
//  expenses
//
//  Created by Kevin Edwards on 15/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ExpenseDAO.h"
#import "SQLiteAccess.h"

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
	
	NSArray *sqlObjects = [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM expenses"];
	NSMutableArray *expenses = [NSMutableArray arrayWithCapacity:[sqlObjects count]];
	
	
	for(int i=0; i < [sqlObjects count]; i++) {
		
		Expense *expense = [Expense alloc];

		NSDictionary *row = [sqlObjects objectAtIndex:i];
		
		expense.name = [row objectForKey:@"expense_name"];
		expense.expense_id = [[row objectForKey:@"expense_id"] intValue];
		expense.necessary = [[row objectForKey:@"expense_necessary"] boolValue];
		expense.cost = [[row objectForKey:@"expense_cost"] floatValue];
		
		[expenses addObject:expense];
		[expense release];

	}
	
	return [NSArray arrayWithArray:expenses];
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

+ (float) totalNecessaryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchNecessaryExpenseCosts];
	return [ExpenseDAO floatArraySummer:expenses];	
}

+ (float) totalLuxuryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchUnnecessaryExpenseCosts];
	return [ExpenseDAO floatArraySummer:expenses];	
}

+ (float) lastWeeksTotalNecessaryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchLastWeeksNecessaryExpenseCosts];
	return [ExpenseDAO floatArraySummer:expenses];	
}

+ (float) lastWeeksTotalLuxuryExpenseCosts {
	
	NSArray *expenses = [ExpenseDAO fetchLastWeeksLuxuryExpenseCosts];
	return [ExpenseDAO floatArraySummer:expenses];	
}

+ (float) lastMonthsTotalNecessaryExpenseCosts {
	NSArray *expenses = [ExpenseDAO fetchLastMonthsNecessaryExpenseCosts];
	return [ExpenseDAO floatArraySummer:expenses];
}

+ (float) lastMonthsTotalLuxuryExpenseCosts {
	NSArray *expenses = [ExpenseDAO fetchLastMonthsLuxuryExpenseCosts];
	return [ExpenseDAO floatArraySummer:expenses];	
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

+ (NSString *)roundedNumber:(float)numberToRound {
	
	float roundedValue = round(2.0f * numberToRound) / 2.0f;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:1];
	[formatter setRoundingMode: NSNumberFormatterRoundDown];
	
	NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	[formatter release];
	
	return numberString;
	
}

+ (float) floatArraySummer:(NSArray *)floatArray {
	
	float summedValue = 0.0;
	
	int numOfElements = [floatArray count];
	
	for(int i=0; i < numOfElements; i++) {
		summedValue += [[floatArray objectAtIndex:i] floatValue];;
	}	
	return summedValue;
}

+ (NSArray *)fetchLastWeeksNecessaryExpenseCosts {
	
	// sqlite3 date format should conform to: 2009-04-20 08:22:53
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"%Y-%m-%d %H:%M"];
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aWeekAgo = [today addTimeInterval: -7 * 24 * 60 * 60];
	
	//NSString *todayString = [dateFormatter stringFromDate:today];
	NSString *weekAgoString = [dateFormatter stringFromDate:aWeekAgo];
	
	//NSLog(@"Today: %@", todayString);
	//NSLog(@"A week ago: %@", weekAgoString);
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 1 AND created_at >= '%@'", weekAgoString];
	
	//NSLog(@"QUERY STRING: %@", queryString);
	
	return [SQLiteAccess selectManyValuesWithSQL:queryString];
}

+ (NSArray *)fetchLastWeeksLuxuryExpenseCosts {
	
	// sqlite3 date format should conform to: 2009-04-20 08:22:53
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"%Y-%m-%d %H:%M"];
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aWeekAgo = [today addTimeInterval: -7 * 24 * 60 * 60];
	
	//NSString *todayString = [dateFormatter stringFromDate:today];
	NSString *weekAgoString = [dateFormatter stringFromDate:aWeekAgo];
	
	//NSLog(@"Today: %@", todayString);
	//NSLog(@"A week ago: %@", weekAgoString);
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 0 AND created_at >= '%@'", weekAgoString];
	
	//NSLog(@"QUERY STRING: %@", queryString);
	
	return [SQLiteAccess selectManyValuesWithSQL:queryString];
}

+ (float) lastWeeksPercentageNecessary {
	float totalNecessaryExpenseCosts = [ExpenseDAO lastWeeksTotalNecessaryExpenseCosts];
	float totalLuxuryExpenseCosts = [ExpenseDAO lastWeeksTotalLuxuryExpenseCosts];
	
	//NSLog(@"Total necessary expenses: %f", totalNecessaryExpenseCosts);
	//NSLog(@"Total luxury expenses: %f", totalLuxuryExpenseCosts);
	
	float totalExpenses = totalNecessaryExpenseCosts + totalLuxuryExpenseCosts;
	
	//NSLog(@"Total expenses: %f", totalExpenses);
	
	return (totalNecessaryExpenseCosts / totalExpenses) * 100;
}

+ (NSArray *)fetchLastMonthsNecessaryExpenseCosts {
	// sqlite3 date format should conform to: 2009-04-20 08:22:53
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"%Y-%m-%d %H:%M"];
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aMonthAgo = [today addTimeInterval: -30 * 24 * 60 * 60];
	
	NSString *aMonthAgoString = [dateFormatter stringFromDate:aMonthAgo];
	
	//NSLog(@"A month ago: %@", aMonthAgoString);
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 1 AND created_at >= '%@'", aMonthAgoString];
	
	//NSLog(@"QUERY STRING: %@", queryString);
	
	return [SQLiteAccess selectManyValuesWithSQL:queryString];
	
}

+ (NSArray *)fetchLastMonthsLuxuryExpenseCosts {
	// sqlite3 date format should conform to: 2009-04-20 08:22:53
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"%Y-%m-%d %H:%M"];
	
	NSDate *today = [[NSDate alloc] init];
	NSDate *aMonthAgo = [today addTimeInterval: -30 * 24 * 60 * 60];
	
	NSString *aMonthAgoString = [dateFormatter stringFromDate:aMonthAgo];
	
	//NSLog(@"A month ago: %@", aMonthAgoString);
	NSString *queryString = [NSString stringWithFormat:@"SELECT expense_cost FROM expenses WHERE expense_necessary = 0 AND created_at >= '%@'", aMonthAgoString];
	
	//NSLog(@"QUERY STRING: %@", queryString);
	
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

