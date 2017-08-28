//
//  SMGetQuoteTableViewController.h
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMGetQuoteViewController : UIViewController

@property (assign, nonatomic) NSInteger movingType;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)nextAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;


@end
