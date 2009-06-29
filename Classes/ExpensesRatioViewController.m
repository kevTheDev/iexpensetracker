//
//  AllExpensesRatioViewController.m
//  expenses
//
//  Created by Kevin Edwards on 17/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ExpensesRatioViewController.h"
#import "ExpenseDAO.h"
#import "NewExpenseViewController.h"
#import "ExpensesListViewController.h"
#import "Expense.h"
#import "GraphViewController.h"
#import "Arithmetic.h"

@implementation ExpensesRatioViewController

@synthesize newExpenseViewController;
@synthesize expensesListViewController;
@synthesize graphViewController;

- (IBAction)showListView {
	NSLog(@"POP VIEW");
	//[self presentModalViewController:expensesListViewController animated:YES];
	[[self navigationController] pushViewController:expensesListViewController animated:YES];
}

- (IBAction)showGraphView {
	NSLog(@"POP GRAPH VIEW");
	//[self presentModalViewController:expensesListViewController animated:YES];
	[[self navigationController] pushViewController:graphViewController animated:YES];
}


- (void)setupFramesWithPercentageNecessary:(int)percentageNecessary withPercentageLuxury:(int)percentageLuxury {
	
	NSLog(@"RAS");
	
	if([ExpenseDAO expensesCount] == 0) {
		NSLog(@"NO EXPENSES");
		CGRect necessaryFrame = necessaryLabel.frame;	
		necessaryFrame.origin.x = 0;
		necessaryFrame.origin.y = 0;
		
		necessaryFrame.size.height = 2.15 * (float) 100;
		necessaryLabel.frame = necessaryFrame;
		
		//- (UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
		// To work out the colors - take an RGB value (between 0.0 and 2.55.0 and divide it by 255)
		UIColor *green = [UIColor colorWithRed:0.26 green:0.62 blue:0 alpha:1];		
		necessaryLabel.backgroundColor = green;
		[necessaryLabel setText:@"No Expenses"];
		
		CGRect luxuryFrame = luxuryLabel.frame;
		luxuryFrame.size.height = 0;
		luxuryLabel.frame = luxuryFrame;
		
		return;
	}
	
	CGRect luxuryFrame = luxuryLabel.frame;
	luxuryFrame.origin.x = 0;
	luxuryFrame.origin.y = 0;
	luxuryFrame.size.height = 2.15 * (float) percentageLuxury;	
	luxuryLabel.frame = luxuryFrame;
	UIColor *purple = [UIColor colorWithRed:0.6 green:0.2 blue:0.4 alpha:1];
	luxuryLabel.backgroundColor = purple;
	
	CGRect necessaryFrame = necessaryLabel.frame;	
	necessaryFrame.origin.x = 0;
	necessaryFrame.origin.y = 0 +luxuryLabel.frame.size.height;
	
	necessaryFrame.size.height = 2.15 * (float) percentageNecessary;
	necessaryLabel.frame = necessaryFrame;
	
	//- (UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
	// To work out the colors - take an RGB value (between 0.0 and 2.55.0 and divide it by 255)
	UIColor *green = [UIColor colorWithRed:0.26 green:0.62 blue:0 alpha:1];		
	necessaryLabel.backgroundColor = green;

	return;
}



- (void) segmentAction:(id)sender {

	[self seeExpensesInTimePeriod:[segmentedControl selectedSegmentIndex]];
	return;
}

// time period 0 is MONTHLY
// 1 IS WEEKLY
// 2 IS ALL
- (void)seeExpensesInTimePeriod:(int)timePeriod {
	
	if([ExpenseDAO expensesCount] == 0) {
		[self setupFramesWithPercentageNecessary:0 withPercentageLuxury:0];
		return;
	}
	
	float percentageNecessary = 0;
	
	if(timePeriod == 0) {
		percentageNecessary = [ExpenseDAO lastMonthsPercentageNecessary];
	}
	else if(timePeriod == 1) {
		percentageNecessary = [ExpenseDAO lastWeeksPercentageNecessary];
	}
	else {
		percentageNecessary = [ExpenseDAO percentageNecessary];
	}
	
	
	percentageNecessary = [Arithmetic roundFloatToInteger:percentageNecessary];
	float percentageLuxury = 100 - percentageNecessary;
	
	NSLog(@"NEC: %f%", percentageNecessary);
	NSLog(@"LUX: %f%", percentageLuxury);

	//NSString *percentageNecessaryString;
	//NSString *percentageLuxuryString;
	
	//if(percentageNecessary < 100) {
//		percentageNecessaryString = [NSString stringWithFormat:@"%@%%", [ExpenseDAO roundedWholeNumber:percentageNecessary]];
//	}
//	else {
//		percentageNecessaryString = @"100%";
//	}
//	
//	if(percentageLuxury < 100) {
//		percentageLuxuryString = [NSString stringWithFormat:@"%@%%", [ExpenseDAO roundedWholeNumber:percentageLuxury]];
//	}
//	else {
//		percentageLuxuryString = @"100%";
//	}

	
	
	float totalNecessaryExpenseCosts = [ExpenseDAO lastMonthsTotalNecessaryExpenseCosts];
	NSString *totalNecessaryExpensesString = [Expense formatExpenseValue:totalNecessaryExpenseCosts];
	
	float totalLuxuryExpenseCosts = [ExpenseDAO lastMonthsTotalLuxuryExpenseCosts];
	NSString *totalLuxuryExpensesString = [Expense formatExpenseValue:totalLuxuryExpenseCosts];
	
    NSString *necessaryLabelString = [NSString stringWithFormat:@"%d%% %@", (int) percentageNecessary, totalNecessaryExpensesString];
	NSString *luxuryLabelString = [NSString stringWithFormat:@"%d%% %@", (int) percentageLuxury, totalLuxuryExpensesString];										  
	
	[self setupFramesWithPercentageNecessary:percentageNecessary withPercentageLuxury:percentageLuxury];
	[self setLabelText:luxuryLabelString necessary:necessaryLabelString];
	
	return;
	
}


- (void) setLabelText:(NSString *)luxuryText necessary:(NSString *)necessaryText {
	if(necessaryLabel.frame.size.height < 30) {
		[necessaryLabel setText:@""];		
	}
	else {
		[necessaryLabel setText:necessaryText];
	}
	
	if(luxuryLabel.frame.size.height < 30) {
		[luxuryLabel setText:@""];
	}
	else {
		[luxuryLabel setText:luxuryText];		
	}
}

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

- (IBAction) showNewExpenseView {
	NSLog(@"SHOW NEW EXPENSE VIEW");
	[[self navigationController] popViewControllerAnimated:YES];
	[[self navigationController] pushViewController:newExpenseViewController animated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self seeExpensesInTimePeriod:0];
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
								   target:self 
								   action:@selector(showNewExpenseView)] autorelease]; 
	self.navigationItem.rightBarButtonItem = addButton;
	self.title = @"Overview";
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	NSLog(@"VIEW WILL APPEAR");
	[self seeExpensesInTimePeriod:0];
	
	Expense *lastExpense = [ExpenseDAO lastExpenseEntered];
	
	
	
	
	if(lastExpense != NULL) {
		
		[staticLastExpenseLabel setText:@"Last expense entered:"];
		staticLastExpenseLabel.minimumFontSize = lastExpenseNameLabel.minimumFontSize;
		
		if(lastExpense.necessary == YES){
			NSLog(@"LAST EXPENSE NECESSARY: %f", lastExpense.cost);
			[lastExpenseNameLabel setText:lastExpense.name];
			lastExpenseNameLabel.textColor = necessaryLabel.backgroundColor;
			percentageChangeLabel.textColor = necessaryLabel.backgroundColor;
			lastExpenseCostLabel.textColor = necessaryLabel.backgroundColor;

		}
		else {
			NSLog(@"LAST EXPENSE LUXURY: %f", lastExpense.cost);
			[lastExpenseNameLabel setText:lastExpense.name];
			lastExpenseNameLabel.textColor = luxuryLabel.backgroundColor;
			percentageChangeLabel.textColor = luxuryLabel.backgroundColor;
			lastExpenseCostLabel.textColor = luxuryLabel.backgroundColor;
		}
		
		[lastExpenseCostLabel setText:[lastExpense formattedExpenseValue]];
		[percentageChangeLabel setText:[ExpenseDAO lastExpensePercentageChange]];
	}
	else {
		[lastExpenseNameLabel setText:@""];
		[percentageChangeLabel setText:@""];
		[lastExpenseCostLabel setText:@""];
		[staticLastExpenseLabel setText:@""];
	}
		
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[newExpenseViewController release];
	[expensesListViewController release];
	[graphViewController release];
    [super dealloc];	
}

- (IBAction)sendFeeback {
	NSString *url = [NSString stringWithString: @"mailto:kev.j.edwards@gmail.com?subject=Expenses%20Feeback"];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];

}



@end
