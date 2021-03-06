//
//  Expense.h
//  iexpensetracker
//
//  Created by Kevin Edwards on 24/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Expense : NSObject {
	NSString *name;
	int expense_id;
	BOOL necessary;
	float cost;
	//NSDate *created_at;
	
}

@property (nonatomic) int expense_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) BOOL necessary;
@property (nonatomic) float cost;
//@property (nonatomic, retain) NSDate *created_at;

- (NSString *)formattedExpenseValue;
+ (NSString *)formatExpenseValue:(float)expenseValue;

@end
