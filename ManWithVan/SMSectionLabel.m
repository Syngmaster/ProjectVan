//
//  SMSectionLabel.m
//  ManWithVan
//
//  Created by Syngmaster on 24/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMSectionLabel.h"

@implementation SMSectionLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3);
    
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    
    
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 15, 0, 0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
