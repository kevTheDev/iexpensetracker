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
	IBOutlet UITextField *costTextField;
	IBOutlet UITextField *nameTextField;
	IBOutlet ExpensesListViewController *expensesListViewController;
}

@property (nonatomic, retain) IBOutlet UITextField *costTextField;
@property (nonatomic, retain) IBOutlet UITextField *nameTextField;
@property (nonatomic, retain) IBOutlet ExpensesListViewController *expensesListViewController;

- (IBAction)cancel;
- (IBAction)addNecessaryExpense;
- (IBAction)addUnnecessaryExpense;
- (IBAction)backgroundClick:(id)sender;

- (void)textFieldDidEndEditing:(UITextField *)textField;


@end
