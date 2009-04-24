//
//  expensesViewController.m
//  expenses
//
//  Created by Kevin Edwards on 06/04/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ExpensesListViewController.h"
#import "NewExpenseViewController.h"
#import "SQLiteAccess.h"
#import "ExpenseDAO.h"
#import "ExpensesRatioViewController.h"

@implementation ExpensesListViewController

@synthesize expenses;


- (IBAction)addNewExpense {
	[self presentModalViewController:newExpenseViewController animated:YES];
}

- (IBAction)seeRatioView {
	[self dismissModalViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Expense"; 
	UITableViewCell *cell = 
	[tv dequeueReusableCellWithIdentifier:CellIdentifier]; 
	if (cell == nil) { 
		cell = [[[UITableViewCell alloc]  
				 initWithFrame:CGRectZero 
				 reuseIdentifier:CellIdentifier] autorelease]; 
	}
	//NSArray *expensesArray = [ExpenseDAO fetchExpenses];
	
    cell.text = [[ExpenseDAO fetchExpenses] objectAtIndex:indexPath.row];
	return cell; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *expensesArray = [ExpenseDAO fetchExpenses];
	return [expensesArray count];
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
	
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[tableView reloadData];
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
