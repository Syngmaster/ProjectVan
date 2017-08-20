//
//  SMSideMenuViewController.h
//  SlideOutMenu
//
//  Created by Syngmaster on 18/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMInteractor.h"

@class SMSideMenuViewController;

@protocol SMSideMenuDelegate <NSObject>

- (void)viewController:(SMSideMenuViewController *)viewController isDismissedWithData:(NSInteger) passedData;

@end

@interface SMSideMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <SMSideMenuDelegate> delegate;
@property (strong, nonatomic) SMInteractor *interactor;

- (IBAction)dismissAction:(UIButton *)sender;

@end
