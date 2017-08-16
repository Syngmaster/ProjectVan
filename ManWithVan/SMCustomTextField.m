//
//  SMCustomTextField.m
//  ManWithVan
//
//  Created by Syngmaster on 20/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomTextField.h"
#import "SMDataManager.h"

@implementation SMCustomTextField

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.borderColor = [SMDataManager sharedInstance].baseColor.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 5.0;

    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 1.0;
}

@end
