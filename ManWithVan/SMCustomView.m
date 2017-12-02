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
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 1.0;
    
}

@end
