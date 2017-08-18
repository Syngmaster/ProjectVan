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
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.borderWidth = 1.0;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;

    [UIView setAnimationsEnabled:NO];
    
    CGFloat fontSize = CGRectGetHeight(self.frame)*0.35;
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
    UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.titleLabel.text attributes:attributes];
    
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
    [UIView setAnimationsEnabled:YES];

}



@end
