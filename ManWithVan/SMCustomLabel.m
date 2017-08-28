//
//  SMCustomLabel.m
//  ManWithVan
//
//  Created by Syngmaster on 21/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomLabel.h"

@implementation SMCustomLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.shadowOffset = CGSizeMake(0.7, 0.7);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 1.0;
    
}


@end
