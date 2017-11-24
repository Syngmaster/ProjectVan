//
//  SMMainTabBarController.m
//  ManWithVan
//
//  Created by Syngmaster on 24/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMainTabBarController.h"

@interface SMMainTabBarController ()

@end

@implementation SMMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *image = [UIImage imageNamed:@"quote_tab_icon.png"];
    [self addRaisedCenterButtonWithImage:image highlightedImage:nil andOffset:-3.0];
    self.tabBar
}

@end
