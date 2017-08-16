//
//  SMPresentMenuAnimator.m
//  SlideOutMenu
//
//  Created by Syngmaster on 18/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import "SMPresentMenuAnimator.h"
#import "SMSideMenuViewController.h"

@implementation SMPresentMenuAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(nonnull id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    UIView *snapshot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    snapshot.tag = 1;
    snapshot.userInteractionEnabled = NO;
    snapshot.layer.opacity = 1.0;
    [containerView insertSubview:snapshot aboveSubview:toVC.view];
    fromVC.view.hidden = YES;
    
    if ([toVC isKindOfClass:[SMSideMenuViewController class]]) {
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            snapshot.center = CGPointMake(snapshot.center.x + CGRectGetWidth([UIScreen mainScreen].bounds) * 0.6 , snapshot.center.y);
            
        } completion:^(BOOL finished) {
            
            fromVC.view.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    } else {
        
        snapshot.center = CGPointMake(snapshot.center.x + CGRectGetWidth([UIScreen mainScreen].bounds) , snapshot.center.y);
        fromVC.view.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    }

}



@end
