//
//  SMReviewsViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 16/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenusParentViewController.h"

@interface SMReviewsViewController : SMSideMenusParentViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)openMenu:(UIButton *)sender;

@end
