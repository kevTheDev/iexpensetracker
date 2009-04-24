//
//  AllExpensesRatioViewController.m
//  expenses
//
//  Created by Kevin Edwards on 17/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ExpensesRatioViewController.h"
#import "ExpenseDAO.h"


@implementation ExpensesRatioViewController

- (void) setupNecessaryRatioFrame:(int)percentageNecessary {
	
	CGRect necessaryFrame = necessaryLabel.frame;	
	necessaryFrame.origin.x = 0;
	necessaryFrame.origin.y = 40;	
	necessaryFrame.size.height = 2.15 * (float) percentageNecessary;
	necessaryLabel.frame = necessaryFrame;
	
	return;
}

- (void) setupLuxuryRatioFrame:(int)percentageLuxury {
	
	CGRect luxuryFrame = luxuryLabel.frame;
	luxuryFrame.origin.x = 0;
	luxuryFrame.origin.y = 40 + necessaryLabel.frame.size.height;
	luxuryFrame.size.height = 2.15 * (float) percentageLuxury;	
	luxuryLabel.frame = luxuryFrame;	
	return;
}

- (IBAction)addNewExpense {
	[self presentModalViewController:newExpensesViewController animated:YES];
}

- (void) segmentAction:(id)sender {
	//UISegmentedControl* segmentedControl = sender;
	if( [segmentedControl selectedSegmentIndex] == 0 ){
		//NSLog(@"you selected the first one!");
		[self seeMonthlyExpenses];
	}
	
	if( [segmentedControl selectedSegmentIndex] == 1 ) {
		//NSLog(@"you selected the second one!");
		[self seeWeeklyExpenses];
	}
	
	if( [segmentedControl selectedSegmentIndex] == 2 ) {
		//NSLog(@"you selected the third one!");
		[self seeAllExpenses];
	}
}

- (IBAction)seeMonthlyExpenses {
	NSLog(@"WEEK PRESSED");
	int percentageNecessary = [ExpenseDAO lastMonthsPercentageNecessary];
	int percentageLuxury = 100 - percentageNecessary;
	
    NSLog(@"ALL PRESSED '%d'", percentageNecessary);
	
	NSString *percentageNecessaryString = [NSString stringWithFormat:@"%d%%", percentageNecessary];
	NSString *percentageLuxuryString = [NSString stringWithFormat:@"%d%%", percentageLuxury];
	
	float totalNecessaryExpenseCosts = [ExpenseDAO lastMonthsTotalNecessaryExpenseCosts];
    NSString *totalNecessaryExpensesString = [ExpenseDAO roundedNumber:totalNecessaryExpenseCosts];
	
	float totalLuxuryExpenseCosts = [ExpenseDAO lastMonthsTotalLuxuryExpenseCosts];
	NSString *totalLuxuryExpensesString = [ExpenseDAO roundedNumber:totalLuxuryExpenseCosts];
	
	
    NSString *necessaryLabelString = [NSString stringWithFormat:@"%@ £%@", percentageNecessaryString, totalNecessaryExpensesString];
	NSString *luxuryLabelString = [NSString stringWithFormat:@"%@ £%@", percentageLuxuryString, totalLuxuryExpensesString];										  
	
	[necessaryLabel setText:necessaryLabelString];
	[luxuryLabel setText:luxuryLabelString];
    
	[self setupNecessaryRatioFrame:percentageNecessary];
	[self setupLuxuryRatioFrame:percentageLuxury];
    
	return;
}

- (IBAction)seeWeeklyExpenses {
	NSLog(@"WEEK PRESSED");
	int percentageNecessary = [ExpenseDAO lastWeeksPercentageNecessary];
	int percentageLuxury = 100 - percentageNecessary;
	
    NSLog(@"ALL PRESSED '%d'", percentageNecessary);
	
	NSString *percentageNecessaryString = [NSString stringWithFormat:@"%d%%", percentageNecessary];
	NSString *percentageLuxuryString = [NSString stringWithFormat:@"%d%%", percentageLuxury];
	
	float totalNecessaryExpenseCosts = [ExpenseDAO lastWeeksTotalNecessaryExpenseCosts];
    NSString *totalNecessaryExpensesString = [ExpenseDAO roundedNumber:totalNecessaryExpenseCosts];
	
	float totalLuxuryExpenseCosts = [ExpenseDAO lastWeeksTotalLuxuryExpenseCosts];
	NSString *totalLuxuryExpensesString = [ExpenseDAO roundedNumber:totalLuxuryExpenseCosts];
	
	
    NSString *necessaryLabelString = [NSString stringWithFormat:@"%@ £%@", percentageNecessaryString, totalNecessaryExpensesString];
	NSString *luxuryLabelString = [NSString stringWithFormat:@"%@ £%@", percentageLuxuryString, totalLuxuryExpensesString];										  
	
	[necessaryLabel setText:necessaryLabelString];
	[luxuryLabel setText:luxuryLabelString];
    
	[self setupNecessaryRatioFrame:percentageNecessary];
	[self setupLuxuryRatioFrame:percentageLuxury];
	
	return;
	
}

- (IBAction)seeAllExpenses {
	
	int percentageNecessary = [ExpenseDAO percentageNecessary];
	int percentageLuxury = 100 - percentageNecessary;
	
    NSLog(@"ALL PRESSED '%d'", percentageNecessary);
	
	NSString *percentageNecessaryString = [NSString stringWithFormat:@"%d%%", percentageNecessary];
	NSString *percentageLuxuryString = [NSString stringWithFormat:@"%d%%", percentageLuxury];
	
	float totalNecessaryExpenseCosts = [ExpenseDAO totalNecessaryExpenseCosts];
    NSString *totalNecessaryExpensesString = [ExpenseDAO roundedNumber:totalNecessaryExpenseCosts];
	
	float totalLuxuryExpenseCosts = [ExpenseDAO totalLuxuryExpenseCosts];
	NSString *totalLuxuryExpensesString = [ExpenseDAO roundedNumber:totalLuxuryExpenseCosts];
	
	
    NSString *necessaryLabelString = [NSString stringWithFormat:@"%@ £%@", percentageNecessaryString, totalNecessaryExpensesString];
	NSString *luxuryLabelString = [NSString stringWithFormat:@"%@ £%@", percentageLuxuryString, totalLuxuryExpensesString];										  
	
	[necessaryLabel setText:necessaryLabelString];
	[luxuryLabel setText:luxuryLabelString];
    
	[self setupNecessaryRatioFrame:percentageNecessary];
	[self setupLuxuryRatioFrame:percentageLuxury];
    
	return;
	
	
}


- (IBAction)seeListView {
	[self presentModalViewController:expensesViewController animated:YES];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self seeMonthlyExpenses];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self seeMonthlyExpenses];
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
    [super dealloc];
}


@end
