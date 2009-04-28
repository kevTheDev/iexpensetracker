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
}

@property (nonatomic) int expense_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) BOOL necessary;
@property (nonatomic) float cost;


@end
