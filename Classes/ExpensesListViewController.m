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

- (IBAction)showRatioView {
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

- (IBAction) showNewExpenseView {
	NSLog(@"SHOW NEW EXPENSE VIEW");
	[[self navigationController] pushViewController:newExpenseViewController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
								   target:self 
								   action:@selector(showNewExpenseView)] autorelease]; 
	self.navigationItem.rightBarButtonItem = addButton;
	self.title = @"Expenses";
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
	[newExpenseViewController release];
	[expensesRatioViewController release];
    [super dealloc];
}

@end
