//
//  iexpensetrackerAppDelegate.m
//  iexpensetracker
//
//  Created by Kevin Edwards on 23/04/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iexpensetrackerAppDelegate.h"
#import "RootViewController.h"
#import "NewExpenseViewController.h"
#import "ExpensesListViewController.h"
#import "ExpensesRatioViewController.h"


@implementation iexpensetrackerAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize newExpenseViewController;
@synthesize expensesListViewController;
@synthesize expensesRatioViewController;
@synthesize toolbar;

- (IBAction) cancel {
	[navigationController popViewControllerAnimated:YES];
}

- (IBAction) showNewExpenseView {
	self.newExpenseViewController.title = @"Add Expense";
	[navigationController pushViewController:newExpenseViewController animated:YES];		
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];	
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[newExpenseViewController release];
	[expensesRatioViewController release];
	[expensesListViewController release];
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
