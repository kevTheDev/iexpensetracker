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

@synthesize expensesListViewController;

- (IBAction)backgroundClick:(id)sender {
	[costTextField resignFirstResponder];
	[nameTextField resignFirstResponder];	
}

// THE FOLLOWING TWO METHODS SEEM TO BE TRYING TO ACHIEVE THE SAME THING
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



// TODO Refactor to app delegate method
- (IBAction)cancel {
	//[self dismissModalViewControllerAnimated:YES];
	[[self navigationController] popViewControllerAnimated:YES];
}

- (void) addNecessaryExpense {
	NSLog (@"add necessary expense");
	
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	NSString *currentText = [costTextField text];
	NSNumber *currentValueNumber = [currencyFormatter numberFromString:currentText];
	NSLog(@"ADD FLOAT: %f", [currentValueNumber floatValue]);
	
	
	NSString *sql = [NSString stringWithFormat:@"INSERT INTO expenses (expense_name, expense_cost, expense_necessary, created_at) VALUES ('%@', %f, 1, current_timestamp)", [nameTextField text], [currentValueNumber floatValue]];
	
	[SQLiteAccess insertWithSQL:sql];
	[currencyFormatter release];
	[[self navigationController] popViewControllerAnimated:YES];
}

- (void) addUnnecessaryExpense {
	NSLog (@"add unnecessary expense");
	
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	NSString *currentText = [costTextField text];
	NSNumber *currentValueNumber = [currencyFormatter numberFromString:currentText];
	NSLog(@"ADD FLOAT: %f", [currentValueNumber floatValue]);
	
	
	NSString *sql = [NSString stringWithFormat:@"INSERT INTO expenses (expense_name, expense_cost, expense_necessary, created_at) VALUES ('%@', %f, 0, current_timestamp)", [nameTextField text], [currentValueNumber floatValue]];
	[SQLiteAccess insertWithSQL:sql];
	[currencyFormatter release];
	[[self navigationController] popViewControllerAnimated:YES];
	
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
	self.title = @"Add Expense";
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	if(textField.tag == 2) {
		return YES;
	}
		
	
	NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
	[currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	NSString *currentText = [textField text];
	NSNumber *currentValueNumber = [currencyFormatter numberFromString:currentText];
	NSLog(@"CURRENT TEXT: %@", [textField text]);
	
	NSLog(@"stringEntered: %@", string);
	
	float currentValue = [currentValueNumber floatValue];
	NSLog(@"CURRENT VALUE: %f", currentValue);
	
	float finalValue = 0.0;
	
	if(string.length == 0) {
		NSLog(@"DELETE");
		finalValue = (currentValue / 10);
	}
	else {
    
		float newValue = [string floatValue];
		NSLog(@"NEW VALUE: %f", newValue);
		finalValue = (currentValue * 10) + (newValue / 100);
	}
	
	
	
	NSLog(@"FINAL VALUE: %f", finalValue);
	
	//float number = 	
	NSNumber *result = [NSNumber numberWithFloat:finalValue];
	
	//NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	//[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	//[numberFormatter setDecimalSeparator:@","];
	//[numberFormatter setFormat:@"0.00;0.00;-0.00"];
	
	NSString *resultText = [currencyFormatter stringFromNumber:result];
	//NSString *resultText = [NSString stringWithFormat:@"%f", [result floatValue]];
	NSLog(@"Result: %@", resultText);

	[textField setText:resultText];// = resultText;
	
	//NSDecimal *number = (NSDecimal)	[text floatValue];
//	[currencyFormatter stringFromNumber
	
	
	//if(text.count == 1)
//	{
//		NSLog(@"NEW TEXT: %@", 
//	}
    [currencyFormatter release];
	return NO;
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
	[expensesListViewController release];
	[costTextField release];
	[nameTextField release];
    [super dealloc];
}







@end
