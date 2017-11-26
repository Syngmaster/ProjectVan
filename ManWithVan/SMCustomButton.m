//
//  SMCustomButton.m
//  ManWithVan
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomButton.h"

@implementation SMCustomButton

- (void)layoutSubviews {
    [super layoutSubviews];    
    
    self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:98.0/255.0 blue:0.0/255.0 alpha:1.0];

    [UIView setAnimationsEnabled:NO];
    
    CGFloat fontSize = CGRectGetHeight(self.frame)*0.5;
    UIFont *font = [UIFont fontWithName:@"Gotham-Book" size:fontSize];
    UIColor *textColor = [UIColor whiteColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributes];
    
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
    [UIView setAnimationsEnabled:YES];
    
}



@end
