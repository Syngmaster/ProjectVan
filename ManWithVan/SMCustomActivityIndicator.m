//
//  SMCustomActivityIndicator.m
//  ManWithVan
//
//  Created by Syngmaster on 13/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomActivityIndicator.h"
#import "SMDataManager.h"

@interface SMCustomActivityIndicator ()

@end

@implementation SMCustomActivityIndicator


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect backgroundFrame = frame;
        backgroundFrame.size.width = frame.size.width - 50;
        backgroundFrame.size.height = frame.size.height - 350;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:backgroundFrame];
        backgroundView.backgroundColor = [UIColor grayColor];
        backgroundView.layer.borderColor = [SMDataManager sharedInstance].baseColor.CGColor;
        backgroundView.layer.borderWidth = 1.0;
        backgroundView.layer.cornerRadius = CGRectGetWidth(self.frame)/10;
        CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        backgroundView.center = center;
        [self addSubview:backgroundView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
        label.text = @"Calculating quote...";
        label.textColor = [SMDataManager sharedInstance].baseColor;
        label.font = [UIFont fontWithName:@"Avenir-Black" size:28];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = center;
        [self addSubview:label];
        
        CGRect imageFrame = CGRectMake(0, 0, 74, 36);
        CGPoint imageCenter = CGPointMake(CGRectGetMidX(self.frame) * 0.5, CGRectGetMidY(self.frame)*1.2);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        imageView.center = imageCenter;
        imageView.image = [UIImage imageNamed:@"Truck_animation.png"];
        [self addSubview:imageView];
        
        [self animateView:imageView];

    }
    return self;
}

- (void)animateView:(UIImageView *) imageView {
    
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        CGPoint imageCenter = CGPointMake(CGRectGetMidX(self.frame) * 1.5, CGRectGetMidY(self.frame)*1.2);
        imageView.center = imageCenter;
    } completion:^(BOOL finished) {
        
        
    }];
    
}

@end
