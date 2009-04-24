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

@interface ExpensesListViewController : UITableViewController <UITableViewDataSource> {
	IBOutlet NewExpenseViewController *newExpenseViewController;
	IBOutlet ExpensesRatioViewController *expensesRatioViewController;
	IBOutlet UITableView *tableView;
}

- (IBAction)showNewExpenseView;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

