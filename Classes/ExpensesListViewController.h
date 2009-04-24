//
//  expensesViewController.h
//  expenses
//
//  Created by Kevin Edwards on 06/04/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewExpenseViewController;
@class ExpensesRatioViewController;

@interface ExpensesListViewController : UIViewController <UITableViewDataSource> {
	IBOutlet NewExpenseViewController *newExpenseViewController;
	IBOutlet ExpensesRatioViewController *expensesRatioViewController;
	IBOutlet UITableView *tableView;
}

- (IBAction)showRatioView;
- (IBAction)showNewExpenseView;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end

