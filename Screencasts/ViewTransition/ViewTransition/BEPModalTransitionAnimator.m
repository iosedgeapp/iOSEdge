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
    UIView* containerView = [transitionContext containerView];
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* fromView = fromVC.view;
    
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* toView = toVC.view;

    if (self.direction == BEPModelTransitionDirectionPresent) {
        CGRect finalFrame = toView.frame;
        
        CGRect startingFrame = CGRectOffset(fromView.frame, -500, 0);
        toView.frame = startingFrame;
        // toView.transform = CGAffineTransformMakeRotation(M_PI);
        
        [containerView insertSubview:toView aboveSubview:fromView];

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                              delay:0
//             usingSpringWithDamping:0.75
//              initialSpringVelocity:0.5
//                            options:0
                         animations:^{
                             toView.frame = finalFrame;
                             //toView.transform = CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        CGRect startingFrame = fromView.frame;
        CGRect finalFrame = CGRectOffset(startingFrame, 0, 500);

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromView.frame = finalFrame;
                         } completion:^(BOOL finished) {
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    }
}

@end
