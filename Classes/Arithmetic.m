//
//  Arithmetic.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 29/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Arithmetic.h"


@implementation Arithmetic

+ (float) floatArraySummer:(NSArray *)floatArray {
	
	float summedValue = 0.0;
	
	int numOfElements = [floatArray count];
	
	for(int i=0; i < numOfElements; i++) {
		summedValue += [[floatArray objectAtIndex:i] floatValue];;
	}	
	return summedValue;
}

+ (NSString *)roundedNumber:(float)numberToRound {
	
	float roundedValue = round(2.0f * numberToRound) / 2.0f;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:2];
	[formatter setRoundingMode: NSNumberFormatterRoundUp];
	
	NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	[formatter release];
	
	return numberString;
	
}

+ (NSString *)roundedWholeNumber:(float)numberToRound {
	float roundedValue = round(2.0f * numberToRound) / 2.0f;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:0];
	[formatter setRoundingMode: NSNumberFormatterRoundUp];
	
	NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	[formatter release];
	
	return numberString;
}

+ (float)roundFloatToInteger:(float)numberToRound {
	float roundedValue = round(2.0f * numberToRound) / 2.0f;
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setMaximumFractionDigits:0];
	[formatter setRoundingMode: NSNumberFormatterRoundUp];
	
	NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
	[formatter release];
	
	float wholeValue = [numberString floatValue];
	return wholeValue;
}


@end
