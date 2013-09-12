//
//  BEPNavigationTransitionsPushAnimator.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPNavigationTransitionsPushAnimator.h"

@implementation BEPNavigationTransitionsPushAnimator

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Animated Transitioning
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    static const CGFloat DampingConstant = 0.75;
    static const CGFloat InitialVelocity = 0.0;
    
    UIView * inView = [transitionContext containerView];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * fromView = [fromVC view];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * toView = [toVC view];
    
    inView.backgroundColor = [UIColor blackColor];
    

    
    CGRect finalRect = [transitionContext finalFrameForViewController:toVC];
    CGRect initialRect = CGRectInset(finalRect,
                                     0.4*CGRectGetWidth(finalRect),
                                     0.4*CGRectGetHeight(finalRect));

    toView.alpha = 0.0;
    toView.frame = initialRect;
    toView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [inView insertSubview:toView aboveSubview:fromView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:DampingConstant
          initialSpringVelocity:InitialVelocity
                        options:0
                     animations:^{
                         toView.alpha = 1.0;
                         toView.frame = finalRect;
                         toView.transform = CGAffineTransformIdentity;
                         fromView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         fromView.alpha = 1.0;
                         [transitionContext completeTransition:YES];
                     }];
}

@end
