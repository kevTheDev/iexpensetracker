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

@implementation ExpensesRatioViewController

@synthesize newExpenseViewController;
@synthesize expensesListViewController;

- (IBAction)showListView {
	NSLog(@"POP VIEW");
	//[self presentModalViewController:expensesListViewController animated:YES];
	[[self navigationController] pushViewController:expensesListViewController animated:YES];
}

- (void) setupNecessaryRatioFrame:(int)percentageNecessary {
	
	CGRect necessaryFrame = necessaryLabel.frame;	
	necessaryFrame.origin.x = 0;
	necessaryFrame.origin.y = 0;	
	necessaryFrame.size.height = 2.15 * (float) percentageNecessary;
	necessaryLabel.frame = necessaryFrame;
	
	return;
}

- (void) setupLuxuryRatioFrame:(int)percentageLuxury {
	
	CGRect luxuryFrame = luxuryLabel.frame;
	luxuryFrame.origin.x = 0;
	luxuryFrame.origin.y = 0 + necessaryLabel.frame.size.height;
	luxuryFrame.size.height = 2.15 * (float) percentageLuxury;	
	luxuryLabel.frame = luxuryFrame;	
	return;
}


- (void) segmentAction:(id)sender {

	if( [segmentedControl selectedSegmentIndex] == 0 ){
		[self seeMonthlyExpenses];
	}
	else if( [segmentedControl selectedSegmentIndex] == 1 ) {
		[self seeWeeklyExpenses];
	}
	else if( [segmentedControl selectedSegmentIndex] == 2 ) {
		[self seeAllExpenses];
	}
}

- (IBAction)seeMonthlyExpenses {
	NSLog(@"MONTH PRESSED");
	float percentageNecessary = [ExpenseDAO lastMonthsPercentageNecessary];
	float percentageLuxury = 100 - percentageNecessary;
	
	NSLog(@"NEC: %f%", percentageNecessary);
	NSLog(@"LUX: %f%", percentageLuxury);
	
	NSString *realPercentageNecessary = [ExpenseDAO roundedNumber:percentageNecessary];
	NSString *realPercentageLuxury = [ExpenseDAO roundedNumber:percentageLuxury];
		
	NSString *percentageNecessaryString = [NSString stringWithFormat:@"%@%%", realPercentageNecessary];
	NSString *percentageLuxuryString = [NSString stringWithFormat:@"%@%%", realPercentageLuxury];
	
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
	float percentageNecessary = [ExpenseDAO lastWeeksPercentageNecessary];
	float percentageLuxury = 100 - percentageNecessary;
	
	NSLog(@"NEC: %f%", percentageNecessary);
	NSLog(@"LUX: %f%", percentageLuxury);
	
	NSString *realPercentageNecessary = [ExpenseDAO roundedNumber:percentageNecessary];
	NSString *realPercentageLuxury = [ExpenseDAO roundedNumber:percentageLuxury];
	
	NSString *percentageNecessaryString = [NSString stringWithFormat:@"%@%%", realPercentageNecessary];
	NSString *percentageLuxuryString = [NSString stringWithFormat:@"%@%%", realPercentageLuxury];
	
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
	
	float percentageNecessary = [ExpenseDAO percentageNecessary];
	float percentageLuxury = 100 - percentageNecessary;
	
    NSLog(@"ALL PRESSED '%f'", percentageNecessary);
	
	
	NSLog(@"NEC: %f%", percentageNecessary);
	NSLog(@"LUX: %f%", percentageLuxury);
	
	NSString *realPercentageNecessary = [ExpenseDAO roundedNumber:percentageNecessary];
	NSString *realPercentageLuxury = [ExpenseDAO roundedNumber:percentageLuxury];
	
	NSString *percentageNecessaryString = [NSString stringWithFormat:@"%@%%", realPercentageNecessary];
	NSString *percentageLuxuryString = [NSString stringWithFormat:@"%@%%", realPercentageLuxury];
	
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
	[self seeMonthlyExpenses];
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
								   target:self 
								   action:@selector(showNewExpenseView)] autorelease]; 
	self.navigationItem.rightBarButtonItem = addButton;
	self.title = @"Overview";
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self seeMonthlyExpenses];
	
	Expense *lastExpense = [ExpenseDAO lastExpenseEntered];
	
	
	
	
	if(lastExpense != NULL) {
		
		NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
		[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		
		NSNumber *expenseValue = [NSNumber numberWithFloat:lastExpense.cost];
		NSString *expenseValueString = [currencyFormatter stringFromNumber:expenseValue];
		
		if(lastExpense.necessary == YES){
			NSLog(@"LAST EXPENSE NECESSARY: %f", lastExpense.cost);
			NSString *changeString = [NSString stringWithFormat:@"+ %@", expenseValueString];
			[changeLabel setText:changeString];
			changeLabel.textColor = necessaryLabel.backgroundColor;

		}
		else {
			NSLog(@"LAST EXPENSE LUXURY: %f", lastExpense.cost);
			NSString *changeString = [NSString stringWithFormat:@"- %@", expenseValueString];
			[changeLabel setText:changeString];
			changeLabel.textColor = luxuryLabel.backgroundColor;
		}
	}
	else {
		[changeLabel setText:@"There are no expenses"];
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
    [super dealloc];
}


@end
