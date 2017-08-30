//
//  SMReviewsViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 16/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMReviewsViewController.h"
#import "SMReviewsViewCell.h"
#import "SMReviewsModel.h"


@interface SMReviewsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SMReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenu:(UIButton *)sender {
    
    [self showMenu];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"reviewCell";
    
    SMReviewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[SMReviewsViewCell alloc] init];
    }
    
    SMReviewsModel *model = [[SMReviewsModel alloc] init];
    [cell configureCell:model atIndexPath:indexPath];
    
    return cell;
    
}



@end
