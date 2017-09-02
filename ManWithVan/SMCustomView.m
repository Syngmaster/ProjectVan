//
//  SMCustomView.m
//  ManWithVan
//
//  Created by Syngmaster on 20/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomView.h"
#import "SMDataManager.h"

@implementation SMCustomView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.borderColor = [SMDataManager sharedInstance].baseColor.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = CGRectGetWidth(self.frame)/10;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 1.0;
    
}

@end
