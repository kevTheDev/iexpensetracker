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
	[[UIColor whiteColor] setFill]; 
	UIRectFill(rect);
	
	// got the graphics context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	NSDate *today = [[NSDate alloc] init];
	NSArray *weekOfDates = [DateManipulator aWeekOfDates:today];
	
	NSLog(@"NUMBER OF DATES: %d", [weekOfDates count]);
	
	//NSMutableArray *weeksLuxuryPercentages = [NSMutableArray arrayWithCapacity:7];
	
	float luxuryPercentages[7];
	float necessaryPercentages[7];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"Y-m-d"];

	
	for(int i=0; i<7; i++) {
		NSDate *date = [weekOfDates objectAtIndex:i];
		
		luxuryPercentages[i] = [ExpenseDAO luxuryPercentageForDay:date];
		//NSLog(@"LUXURY PERCENTAGE: %f on day: %@", luxuryPercentages[i], [dateFormatter stringFromDate:date]);
		
		necessaryPercentages[i] = 100.0 - luxuryPercentages[i];
		
		//NSLog(@"NECESSARY PERCENTAGE: %fon day %@", necessaryPercentages[i], [dateFormatter stringFromDate:date]);
	}
	
	CGContextSelectFont(ctx, "Helvetica", 14.0, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
	
    CGAffineTransform xform = CGAffineTransformMake(
													1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
    CGContextSetTextMatrix(ctx, xform);
	
		
	
	for(int i=0; i<7; i++) {
		
		float percentage = luxuryPercentages[i];
		float necessary = necessaryPercentages[i];
		NSDate *day = [weekOfDates objectAtIndex:i];
		
		NSString *luxuryPercentageData = [NSString stringWithFormat:@"%@: %f %f", [dateFormatter stringFromDate:day], percentage, necessary];
		

		
		CGContextShowTextAtPoint(ctx, 15, 50 * i, [luxuryPercentageData UTF8String], strlen([luxuryPercentageData UTF8String]));
	}
	
	
}


- (void)dealloc {
    [super dealloc];
}

@end
