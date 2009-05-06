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

- (void) setupLuxuryRatioFrame:(int)percentageLuxury {
	
	CGRect luxuryFrame = luxuryLabel.frame;
	luxuryFrame.origin.x = 0;
	luxuryFrame.origin.y = 0;
	luxuryFrame.size.height = 2.15 * (float) percentageLuxury;	
	luxuryLabel.frame = luxuryFrame;
	UIColor *newColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.4 alpha:1];
	luxuryLabel.backgroundColor = newColor;
	
	
	
	return;
}

- (void) setupNecessaryRatioFrame:(int)percentageNecessary {
	
	CGRect necessaryFrame = necessaryLabel.frame;	
	necessaryFrame.origin.x = 0;
	necessaryFrame.origin.y = 0 +luxuryLabel.frame.size.height;	
	necessaryFrame.size.height = 2.15 * (float) percentageNecessary;
	necessaryLabel.frame = necessaryFrame;
	
	//- (UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
	// To work out the colors - take an RGB value (between 0.0 and 2.55.0 and divide it by 255)
	UIColor *newColor = [UIColor colorWithRed:0.26 green:0.62 blue:0 alpha:1];		
	necessaryLabel.backgroundColor = newColor;
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
	
	[self setupNecessaryRatioFrame:percentageNecessary];
	[self setupLuxuryRatioFrame:percentageLuxury];
	
	[self setLabelText:luxuryLabelString necessary:necessaryLabelString];

    
	
	
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
	
	[self setupNecessaryRatioFrame:percentageNecessary];
	[self setupLuxuryRatioFrame:percentageLuxury];
	
	[self setLabelText:luxuryLabelString necessary:necessaryLabelString];

    
	
		
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
	
	[self setupNecessaryRatioFrame:percentageNecessary];
	[self setupLuxuryRatioFrame:percentageLuxury];
	
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

- (IBAction)sendFeeback {
	NSString *url = [NSString stringWithString: @"mailto:kev.j.edwards@gmail.com?subject=Expenses%20Feeback"];
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];

}



@end
