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
#import "SMMainViewController.h"
#import "SMRequestCallbackViewController.h"

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
        
}

- (IBAction)showMenuAction:(UIButton *)sender {
    
    [self showMenu];
    
}

@end
