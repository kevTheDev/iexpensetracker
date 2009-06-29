//
//  Arithmetic.h
//  iexpensetracker
//
//  Created by Kevin Edwards on 29/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Arithmetic : NSObject {

}

+ (float) floatArraySummer:(NSArray *)floatArray;

+ (NSString *)roundedNumber:(float)numberToRound;
+ (NSString *)roundedWholeNumber:(float)numberToRound;
+ (float)roundFloatToInteger:(float)numberToRound;

@end
