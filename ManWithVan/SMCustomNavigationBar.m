//
//  SMCustomNavigationBar.m
//  ManWithVan
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomNavigationBar.h"
#import "SMMapViewController.h"
#import "SMLocationSettingsViewController.h"

@implementation SMCustomNavigationBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIBarButtonItem *callUsButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(callUsAction:)];
    
    [callUsButton setImage:[[UIImage imageNamed:@"CallUsButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.topItem.rightBarButtonItem = callUsButton;
}

- (void)callUsAction:(UIButton *)sender {
    
    if ([UIDevice currentDevice].systemVersion.floatValue < 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0851119555"]];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0851119555"] options:@{} completionHandler:nil];
    }
    
}


@end
