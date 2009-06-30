//
//  DateManipulator.h
//  iexpensetracker
//
//  Created by Kevin Edwards on 29/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateManipulator : NSObject {

}

+ (NSArray *) aWeekOfDates:(NSDate *)endDate;

// returns a string in sqlite3 format from a date
+ (NSString *) sqliteDateTimeString:(NSDate *)date;

@end
