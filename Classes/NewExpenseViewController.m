//
//  NewExpensesViewController.m
//  expenses
//
//  Created by Kevin Edwards on 06/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseViewController.h"
#import "ExpensesListViewController.h"
#import "SQLiteAccess.h"

@implementation NewExpenseViewController

@synthesize costTextField;
@synthesize nameTextField;
@synthesize expensesListViewController;

- (IBAction)backgroundClick:(id)sender {
	[costTextField resignFirstResponder];
	[nameTextField resignFirstResponder];
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	
	if(textField.tag == 1) {		
		NSLog(@"COST SET");
		[costTextField resignFirstResponder];
	}
	else {
		NSLog(@"NAME SET");
		[nameTextField resignFirstResponder];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
	
	[textField resignFirstResponder];
	
	if(textField.tag == 1) {
		[nameTextField becomeFirstResponder];
	}
	
	return YES; 
} 




- (IBAction)cancel {
	//[self dismissModalViewControllerAnimated:YES];
	[[self navigationController] popViewControllerAnimated:YES];
}

- (void) addNecessaryExpense {
	NSLog (@"add necessary expense");
	
	NSString *sql = [NSString stringWithFormat:@"INSERT INTO expenses (expense_name, expense_cost, expense_necessary, created_at) VALUES ('%@', %f, 1, current_timestamp)", [nameTextField text], [[costTextField text] floatValue]];
	
	[SQLiteAccess insertWithSQL:sql];
	[self dismissModalViewControllerAnimated:YES];
}

- (void) addUnnecessaryExpense {
	
	NSString *sql = [NSString stringWithFormat:@"INSERT INTO expenses (expense_name, expense_cost, expense_necessary, created_at) VALUES ('%@', %f, 0, current_timestamp)", [nameTextField text], [[costTextField text] floatValue]];
	[SQLiteAccess insertWithSQL:sql];
	[self dismissModalViewControllerAnimated:YES];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	[costTextField becomeFirstResponder];
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
								   target:self 
								   action:@selector(cancel)] autorelease];
	
	self.navigationItem.leftBarButtonItem = cancelButton;
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
	[costTextField release];
	[nameTextField release];
    [super dealloc];
}







@end
