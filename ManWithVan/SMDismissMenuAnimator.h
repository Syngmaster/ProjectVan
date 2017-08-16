//
//  SMDismissMenuAnimator.h
//  SlideOutMenu
//
//  Created by Syngmaster on 19/07/2017.
//  Copyright © 2017 Syngmaster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SMDismissMenuAnimator : NSObject <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;

- (void)animateTransition:(nonnull id <UIViewControllerContextTransitioning>)transitionContext;


@end
