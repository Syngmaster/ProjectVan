//
//  SMSegueButton.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSegueButton.h"

@implementation SMSegueButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat fontSize = CGRectGetHeight(self.frame)*0.4;
    
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
    
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/8;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 0.75;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;

    UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributes];
    
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
    
}

@end
