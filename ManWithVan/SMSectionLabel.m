//
//  SMSectionLabel.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSectionLabel.h"

@implementation SMSectionLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0].CGColor;
    
    CGFloat fontSize = 16;
    
    UIFont *font = [UIFont fontWithName:@"Avenir-Heavy" size:fontSize];
    
    UIColor *textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    
    self.attributedText = attr;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 15, 0, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
