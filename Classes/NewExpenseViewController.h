//
//  NewExpensesViewController.h
//  expenses
//
//  Created by Kevin Edwards on 06/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <sqlite3.h>

@class ExpensesListViewController;

@interface NewExpenseViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet ExpensesListViewController *showExpensesController;
	NSString *dbFilePath;
	
	IBOutlet UITextField *costTextField;
	IBOutlet UITextField *nameTextField; 
}

@property (nonatomic, retain) UITextField *costTextField;
@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) ExpensesListViewController *showExpensesController;

- (IBAction)cancel;
- (IBAction)addNecessaryExpense;
- (IBAction)addUnnecessaryExpense;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)backgroundClick:(id)sender;

@end
