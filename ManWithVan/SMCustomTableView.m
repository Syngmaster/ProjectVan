//
//  SMCustomTableView.m
//  ManWithVan
//
//  Created by Syngmaster on 20/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomTableView.h"

@implementation SMCustomTableView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);
    
    CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor);
    CGContextStrokePath(context);

}


@end
