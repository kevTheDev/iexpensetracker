//
//  SQLiteAccess.h
//  expenses
//
//  Created by Kevin Edwards on 15/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SQLiteAccess : NSObject {
	
}

+ (NSString *) selectOneValueSQL:(NSString *)sql;
+ (NSArray *) selectManyValuesWithSQL:(NSString *)sql;
+ (NSDictionary *) selectOneRowWithSQL:(NSString *)sql;
+ (NSArray *)selectManyRowsWithSQL:(NSString *)sql;
+ (NSNumber *)insertWithSQL:(NSString *)sql;
+ (void)updateWithSQL:(NSString *)sql;
+ (void)deleteWithSQL:(NSString *)sql;

@end
