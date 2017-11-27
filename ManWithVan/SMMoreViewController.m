//
//  SMMoreViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 26/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMoreViewController.h"
#import "SMMoreViewCell.h"
#import "SMMainTabBarController.h"

@interface SMMoreViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SMMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.title=@"";
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_button_img.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    SMMainTabBarController *rootVC = (SMMainTabBarController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    
    for (UIView *view in rootVC.view.subviews) {
        if (view.tag == 1) {
            UIButton *button = (UIButton *)view;
            button.hidden = NO;
            button.enabled = YES;
            [rootVC.view bringSubviewToFront:view];
        }
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: [self performSegueWithIdentifier:@"review" sender:nil];
            break;
        case 1: [self performSegueWithIdentifier:@"gallery" sender:nil];
            break;
        case 2: [self performSegueWithIdentifier:@"social" sender:nil];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SMMainTabBarController *rootVC = (SMMainTabBarController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;

    for (UIView *view in rootVC.view.subviews) {
        if (view.tag == 1) {
            UIButton *button = (UIButton *)view;
            button.hidden = YES;
            button.enabled = NO;
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


@end
