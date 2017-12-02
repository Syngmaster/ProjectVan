//
//  SMCustomActivityIndicator.m
//  ManWithVan
//
//  Created by Syngmaster on 13/08/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMCustomActivityIndicator.h"
#import "SMDataManager.h"

@implementation SMCustomActivityIndicator


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect backgroundFrame = frame;
        backgroundFrame.size.width = frame.size.width - 40;
        backgroundFrame.size.height = frame.size.height - 300;
        CGPoint center = CGPointMake(self.center.x, self.center.y - 64);

        UIView *backgroundView = [[UIView alloc] initWithFrame:backgroundFrame];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.borderColor = [SMDataManager sharedInstance].baseColor.CGColor;
        backgroundView.layer.borderWidth = 2.0;
        backgroundView.layer.cornerRadius = CGRectGetWidth(self.frame)/10;
        backgroundView.center = center;
        [self addSubview:backgroundView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.frame];
        label.text = @"Calculating quote...";
        label.textColor = [SMDataManager sharedInstance].baseColor;
        label.font = [UIFont fontWithName:@"Gotham-Book" size:28];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = center;
        [self addSubview:label];
        
        CGRect imageFrame = CGRectMake(0, 0, 74, 36);
        CGPoint imageCenter = CGPointMake(CGRectGetMidX(self.frame) * 0.5, center.y*1.2);
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
        CGPoint imageCenter = CGPointMake(CGRectGetMidX(self.frame) * 1.5, (CGRectGetMidY(self.frame)-64)*1.2);
        imageView.center = imageCenter;
    } completion:nil];
    
}

@end
