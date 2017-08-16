//
//  SMAboutUsViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 20/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMAboutUsViewController.h"
#import "SMSideMenuViewController.h"
#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"
#import "SMSignInViewController.h"
#import "SMRequestCallbackViewController.h"

@interface SMAboutUsViewController ()


@end

@implementation SMAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openMenuAction:(UIButton *)sender {
    
    [self showMenu];
    
}

- (IBAction)requestCallbackAction:(UIButton *)sender {
    
    SMRequestCallbackViewController *reqVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SMRequestCallbackViewController"];
    UINavigationController *navVC = (UINavigationController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    [self.navigationController popViewControllerAnimated:NO];
    [navVC pushViewController:reqVC animated:NO];
    
}


@end
