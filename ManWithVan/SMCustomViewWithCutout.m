//
//  SMCustomViewWithCutout.m
//  ManWithVan
//
//  Created by Syngmaster on 24/11/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomViewWithCutout.h"
#import <QuartzCore/QuartzCore.h>


@implementation SMCustomViewWithCutout

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    
    if ((int)[self.layer.sublayers count] < 2) {
        [self addShadowLayer];
    }

}

- (void)addShadowLayer {
    
    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    CGFloat rightPointX = 0.0;
    CGFloat leftPointX = 0.0;
    
    CGFloat leftCurvePointX = 0.0;
    CGFloat leftCurvePointY = 0.0;
    
    CGFloat leftCurveControlPoint1X = 0.0;
    CGFloat leftCurveControlPoint1Y = 0.0;
    CGFloat leftCurveControlPoint2X = 0.0;
    CGFloat leftCurveControlPoint2Y = 0.0;
    
    CGFloat rightCurveControlPoint1X = 0.0;
    CGFloat rightCurveControlPoint1Y = 0.0;
    CGFloat rightCurveControlPoint2X = 0.0;
    CGFloat rightCurveControlPoint2Y = 0.0;
    
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        
        rightPointX = 186.13;
        leftPointX = 123.87;
        
        leftCurvePointX = 155;
        leftCurvePointY = 428;
        leftCurveControlPoint1X = 130.45;
        leftCurveControlPoint1Y = 434.77;
        leftCurveControlPoint2X = 141.93;
        leftCurveControlPoint2Y = leftCurvePointY;
        
        rightCurveControlPoint1X = 168.07;
        rightCurveControlPoint1Y = leftCurvePointY;
        rightCurveControlPoint2X = 179.55;
        rightCurveControlPoint2Y = 434.77;
        
    } else if ([UIScreen mainScreen].bounds.size.width == 375) {
        rightPointX = 213.42;
        leftPointX = 151.58;
        
        leftCurvePointX = 182.5;
        leftCurvePointY = 527.33;
        leftCurveControlPoint1X = 158.2;
        leftCurveControlPoint1Y = 533.96;
        leftCurveControlPoint2X = 169.57;
        leftCurveControlPoint2Y = leftCurvePointY;
        
        rightCurveControlPoint1X = 195.43;
        rightCurveControlPoint1Y = leftCurvePointY;
        rightCurveControlPoint2X = 206.8;
        rightCurveControlPoint2Y = 533.96;
        
    } else if ([UIScreen mainScreen].bounds.size.width == 414) {
        rightPointX = 236.22;
        
        leftPointX = 167.78;
        
        leftCurvePointX = 202;
        leftCurvePointY = 594.22;
        leftCurveControlPoint1X = 175.1;
        leftCurveControlPoint1Y = 601.68;
        leftCurveControlPoint2X = 187.69;
        leftCurveControlPoint2Y = leftCurvePointY;
        
        rightCurveControlPoint1X = 216.31;
        rightCurveControlPoint1Y = leftCurvePointY;
        rightCurveControlPoint2X = 228.9;
        rightCurveControlPoint2Y = 601.68;
    }
    
    [path moveToPoint: CGPointMake(rightPointX, CGRectGetMaxY(self.bounds))];
    [path addLineToPoint: CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path addLineToPoint: CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMinY(self.bounds))];
    [path addLineToPoint: CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds))];
    [path addLineToPoint: CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds))];
    [path addLineToPoint: CGPointMake(leftPointX, CGRectGetMaxY(self.bounds))];
    [path addCurveToPoint: CGPointMake(leftCurvePointX, leftCurvePointY) controlPoint1: CGPointMake(leftCurveControlPoint1X, leftCurveControlPoint1Y) controlPoint2: CGPointMake(leftCurveControlPoint2X, leftCurveControlPoint2Y)];
    [path addCurveToPoint: CGPointMake(rightPointX, CGRectGetMaxY(self.bounds)) controlPoint1: CGPointMake(rightCurveControlPoint1X, rightCurveControlPoint1Y) controlPoint2: CGPointMake(rightCurveControlPoint2X, rightCurveControlPoint2Y)];
    [path closePath];
    path.usesEvenOddFillRule = YES;
    [fillColor setFill];
    [path fill];
    
    CAShapeLayer *shadowLayer = [[CAShapeLayer alloc] init];
    shadowLayer.frame = self.bounds;
    shadowLayer.path = path.CGPath;
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOpacity = 0.8;
    shadowLayer.shadowRadius = 1.5;
    shadowLayer.masksToBounds = NO;
    shadowLayer.shadowOffset = CGSizeMake(1.5, 1.5);
    shadowLayer.fillRule = kCAFillRuleEvenOdd;
    shadowLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:shadowLayer];
    UIView *view = self.subviews[0];
    [self bringSubviewToFront:view];
    
    
}



@end
