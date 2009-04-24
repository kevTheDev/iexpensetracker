//
//  iexpensetrackerAppDelegate.h
//  iexpensetracker
//
//  Created by Kevin Edwards on 23/04/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewExpenseViewController;
@class ExpensesListViewController;
@class ExpensesRatioViewController;

@interface iexpensetrackerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	IBOutlet NewExpenseViewController *newExpenseViewController;
	IBOutlet ExpensesListViewController *expensesListViewController;
	IBOutlet ExpensesRatioViewController *expensesRatioViewController;
	
	UIToolbar *toolbar;
}

- (IBAction) showListView;
- (IBAction) showRatioView;
- (IBAction) showNewExpenseView;
- (IBAction) cancel;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet NewExpenseViewController *newExpenseViewController;
@property (nonatomic, retain) IBOutlet ExpensesListViewController *expensesListViewController;
@property (nonatomic, retain) IBOutlet ExpensesRatioViewController *expensesRatioViewController;
@property (nonatomic, retain) UIToolbar *toolbar;

@end

