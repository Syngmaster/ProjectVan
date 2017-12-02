//
//  BaseTabBarController.m
//  ManWithVan
//
//  Created by Syngmaster on 24/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMBaseTabBarController.h"

@interface SMBaseTabBarController ()

@end

@implementation SMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addRaisedCenterButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage andOffset:(CGFloat)offset {
    
    if ([UIScreen mainScreen].bounds.size.height == 812) {
        offset = offset - 42;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = image.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    if (offset) {
        button.center = CGPointMake(button.center.x, button.center.y + offset);
    }
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    [self.view addSubview:button];
    
}

- (void)buttonAction:(UIButton *)sender {
    
    self.selectedIndex = 2;
    
}


@end
