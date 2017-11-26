//
//  SMMoreViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 26/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMoreViewController.h"
#import "SMMoreViewCell.h"

@interface SMMoreViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SMMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)callUsAction:(UIButton *)sender {
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0851119555"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0851119555"] options:@{} completionHandler:nil];
    }
    
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SMMoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[SMMoreViewCell alloc] init];
    }
    
    [cell configureCellAtRow:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


@end
