//
//  SMAboutUsViewController.m
//  ManWithVan
//
//  Created by Syngmaster on 20/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMAboutUsViewController.h"
#import "SMSideMenuViewController.h"
#import "SMRequestCallbackViewController.h"
#import "SMSignInViewController.h"


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


- (IBAction)requestCallbackAction:(UIButton *)sender {
    
    self.tabBarController.selectedIndex = 3;
    
}


@end
