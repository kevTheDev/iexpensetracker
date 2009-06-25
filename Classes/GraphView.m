//
//  GraphView.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 25/06/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"


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
}


- (void)dealloc {
    [super dealloc];
}

@end
