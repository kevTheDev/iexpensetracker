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
#import "Expense.h"

@implementation ExpensesListViewController

@synthesize expenses;

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath { 
	
	[tableView beginUpdates];
	
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		[expenses removeObjectAtIndex:indexPath.row];
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
	[tableView endUpdates];
	//[tv reloadData];
} 


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Expense"; 
	UITableViewCell *cell = 
	[tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
	if (cell == nil) { 
		cell = [[[UITableViewCell alloc]  
				 initWithFrame:CGRectZero 
				 reuseIdentifier:CellIdentifier] autorelease]; 
	}

	cell.text = [[expenses objectAtIndex:indexPath.row] name];
	//cell.text = @"Hello";
	return cell; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	return self.expensesArray.count;
	//return [expensesArray count];
	//return [[ExpenseDAO fetchExpenses] count];
	NSLog(@"Expenses Count: %d", [expenses count]);

	return [expenses count];
	//return 1;
	
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
	[[self navigationController] pushViewController:newExpenseViewController animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Expenses";
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];	
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (id)initWithCoder:(NSCoder *)coder { 
	if (self = [super initWithCoder:coder]) { 
		self.expenses = [NSMutableArray arrayWithArray:[ExpenseDAO fetchExpenses]];					  
	} 
	return self; 
} 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
	NSLog(@"MEM WARNING");
}


- (void)dealloc {
	[newExpenseViewController release];
	[expensesRatioViewController release];
	[expenses release];
    [super dealloc];
}

@end
