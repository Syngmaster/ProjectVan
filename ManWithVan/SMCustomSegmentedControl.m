//
//  SMCustomSegmentedControl.m
//  ManWithVan
//
//  Created by Syngmaster on 29/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomSegmentedControl.h"

@implementation SMCustomSegmentedControl

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self removeBorders];
    
}

- (void)removeBorders {

    self.tintColor = [UIColor colorWithRed:244/255.0 green:98.0/255.0 blue:0/255.0 alpha:1.0];
    [self setBackgroundImage:[self imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:244/255.0 green:98.0/255.0 blue:0/255.0 alpha:1.0]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setDividerImage:[self imageWithColor:[UIColor clearColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

