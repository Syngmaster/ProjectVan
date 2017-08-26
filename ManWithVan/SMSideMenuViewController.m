//
//  SMSideMenuViewController.m
//  SlideOutMenu
//
//  Created by Syngmaster on 18/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSideMenuViewController.h"
#import "SMSideMenuViewCell.h"

#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"

@interface SMSideMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SMSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:pan];

}


- (IBAction)dismissAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)sender {
    
    CGFloat progress = [sender translationInView:self.view].x / (self.view.frame.size.width * 1.0);
    progress = MAX(0.0, fabs(progress));
    progress = MIN(1.0, progress);
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.interactor.hasStarted = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (sender.state == UIGestureRecognizerStateChanged) {
        [self.interactor updateInteractiveTransition:progress];
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        self.interactor.hasStarted = NO;
        if (progress > 0.4) {
            [self.interactor finishInteractiveTransition];
        }
        else {
            [self.interactor cancelInteractiveTransition];
        }
    } else if (sender.state == UIGestureRecognizerStateCancelled) {
        self.interactor.hasStarted = NO;
        [self.interactor cancelInteractiveTransition];
    }

    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SMSideMenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[SMSideMenuViewCell alloc] init];
    }
    
    [cell configureCell:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];

    } else if (indexPath.row == 1) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];

    } else if (indexPath.row == 2) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];
        
    } else if (indexPath.row == 3) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];
        
    } else if (indexPath.row == 4) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];
        
    } else if (indexPath.row == 5) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];
        
    } else if (indexPath.row == 6) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate viewController:self isDismissedWithData:indexPath.row];
        }];
        
    }
}

@end
