//
//  BEPModalTransitionAnimator.m
//  BepBop
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 9/12/13.
//  Modified by Michael Ang - https://twitter.com/mangtronix
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPModalTransitionAnimator.h"

@interface BEPModalTransitionAnimator ()

@property (nonatomic) BEPModalTransitionDirection direction;

@end

@implementation BEPModalTransitionAnimator

- (instancetype) initWithDirection:(BEPModalTransitionDirection)direction
{
    if (self = [super init])
    {
        _direction = direction;
    }

    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Animated Transition
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.75;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    static const CGFloat DampingConstant = 0.75;
    static const CGFloat InitialVelocity = 0.0;

    UIView* containerView = [transitionContext containerView];
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* fromView         = fromVC.view;
    
    UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* toView = toVC.view;

    if (self.direction == BEPModelTransitionDirectionPresent)
    {
        CGRect finalRect   = toView.frame;
        CGRect initialRect = fromView.frame;
        toView.alpha     = 0.0;
        toView.frame     = initialRect;
        toView.transform = CGAffineTransformMakeRotation(M_PI);
        
        [containerView insertSubview:toView aboveSubview:fromView];

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:DampingConstant
              initialSpringVelocity:InitialVelocity
                            options:0
                         animations:^{
             toView.alpha = 1.0;
             toView.frame = finalRect;
             toView.transform = CGAffineTransformIdentity;
         }
                         completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
         }];
    }
    else
    {
        CGRect initialRect = fromView.frame;
        CGRect finalRect   = CGRectOffset(initialRect, 0, 500);

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:DampingConstant
              initialSpringVelocity:InitialVelocity
                            options:0
                         animations:^{
             fromView.frame = finalRect;
         }
                         completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
         }];
    }
}

@end
