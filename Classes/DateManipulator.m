//
//  DateManipulator.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 29/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DateManipulator.h"


@implementation DateManipulator

NSString *SQLITE_DATE_FORMAT = @"yyyy-MM-dd HH:mm:ss";

// returns a week of dates where the last date is the date passed in
+ (NSArray *) aWeekOfDates:(NSDate *)endDate {
	
	NSMutableArray *week = [NSMutableArray arrayWithCapacity:7];
	
		
	for(int i=7; i > 1; i--) {
		NSDate *tempDate = [endDate addTimeInterval: -i * 24 * 60 * 60];
		[week addObject:tempDate];
	}
	
	[week addObject:endDate];
		 
	return week;
}

// returns a string in sqlite3 format from a date
+ (NSString *) sqliteDateTimeString:(NSDate *)date {
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:SQLITE_DATE_FORMAT];
	
	return [dateFormatter stringFromDate:date];
	
}

@end
