//
//  AllExpensesRatioViewController.h
//  expenses
//
//  Created by Kevin Edwards on 17/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlossyLabel.h"

@class NewExpenseViewController;
@class ExpensesListViewController;
@class GlossyLabel;

@interface ExpensesRatioViewController : UIViewController {
	IBOutlet ExpensesListViewController *expensesListViewController;
	IBOutlet NewExpenseViewController *newExpenseViewController;
	IBOutlet UISegmentedControl *segmentedControl;
	IBOutlet GlossyLabel *ratioLabel;
	IBOutlet GlossyLabel *necessaryLabel;
	IBOutlet GlossyLabel *luxuryLabel;
	IBOutlet UILabel *changeLabel;
}


- (IBAction)seeMonthlyExpenses;
- (IBAction)seeWeeklyExpenses;
- (IBAction)seeAllExpenses;

- (IBAction)showListView;
- (IBAction)showNewExpenseView;
- (IBAction)sendFeeback;

- (void) segmentAction:(id)sender;
- (void) setupNecessaryRatioFrame:(int)percentageNecessary;
- (void) setupLuxuryRatioFrame:(int)percentageLuxury;
- (void) setLabelText:(NSString *)luxuryText necessary:(NSString *)necessaryText;

@property (nonatomic, retain) IBOutlet NewExpenseViewController *newExpenseViewController;
@property (nonatomic, retain) IBOutlet ExpensesListViewController *expensesListViewController;

@end
