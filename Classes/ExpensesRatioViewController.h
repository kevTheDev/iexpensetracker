//
//  AllExpensesRatioViewController.h
//  expenses
//
//  Created by Kevin Edwards on 17/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewExpenseViewController;
@class ExpensesListViewController;

@interface ExpensesRatioViewController : UIViewController {
	IBOutlet ExpensesListViewController *expensesListViewController;
	IBOutlet NewExpenseViewController *newExpenseViewController;
	IBOutlet UISegmentedControl *segmentedControl;
	IBOutlet UILabel *ratioLabel;
	IBOutlet UILabel *necessaryLabel;
	IBOutlet UILabel *luxuryLabel;
}

- (IBAction)seeListView;
- (IBAction)seeMonthlyExpenses;
- (IBAction)seeWeeklyExpenses;
- (IBAction)seeAllExpenses;
- (IBAction)showNewExpenseView;

- (void) segmentAction:(id)sender;
- (void) setupNecessaryRatioFrame:(int)percentageNecessary;
- (void) setupLuxuryRatioFrame:(int)percentageLuxury;

@property (nonatomic, retain) IBOutlet NewExpenseViewController *newExpenseViewController;
@property (nonatomic, retain) IBOutlet ExpensesListViewController *expensesListViewController;

@end
