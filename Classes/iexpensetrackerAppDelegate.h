//
//  iexpensetrackerAppDelegate.h
//  iexpensetracker
//
//  Created by Kevin Edwards on 23/04/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewExpenseViewController;

@interface iexpensetrackerAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	IBOutlet NewExpenseViewController *newExpenseViewController;
}

- (IBAction) showListView;
- (IBAction) showRatioView;
- (IBAction) showNewExpenseView;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet NewExpenseViewController *newExpenseViewController;

@end

