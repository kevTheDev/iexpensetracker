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

- (NSString *)formattedExpenseValue {
	
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	
	NSNumber *expenseValue = [NSNumber numberWithFloat:self.cost];
	NSString *expenseValueString = [currencyFormatter stringFromNumber:expenseValue];
	
	[currencyFormatter release];
	return expenseValueString;
}
	

@end
