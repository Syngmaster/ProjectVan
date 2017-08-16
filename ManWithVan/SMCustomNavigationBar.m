//
//  SMCustomNavigationBar.m
//  ManWithVan
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomNavigationBar.h"

@implementation SMCustomNavigationBar


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.tintColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0];
    self.titleTextAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Avenir-Heavy" size:20], NSForegroundColorAttributeName : [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0] };

}

/*- (nullable UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
    return [super popNavigationItemAnimated:NO];
}*/

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5);

    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:185.0/255.0 alpha:1.0].CGColor);
    CGContextStrokePath(context);
    
}


@end
