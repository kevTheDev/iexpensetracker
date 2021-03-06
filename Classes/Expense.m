//
//  Expense.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 24/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Expense.h"


@implementation Expense

@synthesize name;
@synthesize expense_id;
@synthesize necessary;
@synthesize cost;
//@synthesize created_at;

- (NSString *)formattedExpenseValue {
	
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	
	NSNumber *expenseValue = [NSNumber numberWithFloat:self.cost];
	NSString *expenseValueString = [currencyFormatter stringFromNumber:expenseValue];
	
	[currencyFormatter release];
	return expenseValueString;
}

+ (NSString *)formatExpenseValue:(float)expenseValue {
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	
	NSNumber *expenseValueNumber = [NSNumber numberWithFloat:expenseValue];
	NSString *expenseValueString = [currencyFormatter stringFromNumber:expenseValueNumber];
	
	[currencyFormatter release];
	return expenseValueString;
}
	

@end
