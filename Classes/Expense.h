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
//	NSInteger *id;
}

//@property (nonatomic, retain) 
@property (nonatomic, retain) NSString *name;

- (void)initWithName:(NSString *)expense_name;

@end
