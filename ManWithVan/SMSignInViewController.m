//
//  SMSignInViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 20/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSignInViewController.h"
#import "SMSideMenuViewController.h"
#import "SMAboutUsViewController.h"
#import "SMCustomNavigationBar.h"
#import "SMMainViewController.h"
#import "SMRequestCallbackViewController.h"

#import "SMPresentMenuAnimator.h"
#import "SMDismissMenuAnimator.h"


@interface SMSignInViewController () 
@end

@implementation SMSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(UIButton *)sender {
    
    //[self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (IBAction)showMenuAction:(UIButton *)sender {
    
    [self showMenu];
    
}


@end
