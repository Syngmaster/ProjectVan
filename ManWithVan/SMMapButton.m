//
//  SMMapButton.m
//  ManWithVan
//
//  Created by Syngmaster on 30/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMMapButton.h"

@implementation SMMapButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    //self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    //self.layer.borderColor = [UIColor blackColor].CGColor;
    //self.layer.borderWidth = 1.0;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;
    
}

@end
