//
//  GraphView.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 25/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "DateManipulator.h"
#import "ExpenseDAO.h"

@implementation GraphView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	[[UIColor blueColor] setFill]; 
	UIRectFill(rect);
	
	NSDate *today = [[NSDate alloc] init];
	NSArray *weekOfDates = [DateManipulator aWeekOfDates:today];
	
	NSLog(@"NUMBER OF DATES: %d", [weekOfDates count]);
	
	//NSMutableArray *weeksLuxuryPercentages = [NSMutableArray arrayWithCapacity:7];
	
	float luxuryPercentages[7];
	float necessaryPercentages[7];
	
	for(int i=0; i<7; i++) {
		luxuryPercentages[i] = [ExpenseDAO luxuryPercentageForDay:[weekOfDates objectAtIndex:i]];
		NSLog(@"LUXURY PERCENTAGE: %f", luxuryPercentages[i]);
		
		necessaryPercentages[i] = 100.0 - luxuryPercentages[i];
		
		NSLog(@"NECESSARY PERCENTAGE: %f", necessaryPercentages[i]);
	}
}


- (void)dealloc {
    [super dealloc];
}

@end
