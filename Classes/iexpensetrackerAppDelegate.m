//
//  iexpensetrackerAppDelegate.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 23/04/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iexpensetrackerAppDelegate.h"
#import "RootViewController.h"


@implementation iexpensetrackerAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
