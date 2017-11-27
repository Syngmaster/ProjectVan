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
    
    UIFont *font = [UIFont fontWithName:@"Gotham-Book" size:14];
    UIColor *textColor = [UIColor blackColor];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor, NSFontAttributeName : font};
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    self.attributedText = attr;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 10, 0, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0].CGColor);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.size.width, rect.origin.y);
    CGContextStrokePath(context);

}

@end
