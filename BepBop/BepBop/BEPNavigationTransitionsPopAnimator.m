//
//  BEPNavigationTransitionsPopAnimator.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPNavigationTransitionsPopAnimator.h"

@implementation BEPNavigationTransitionsPopAnimator

- (instancetype)initWithNavigationController:(UINavigationController *)nc
{
    if (self = [super init]) {
        self.parent = nc;
        
        UIPinchGestureRecognizer * pgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(handlePinch:)];
        
        [self.parent.view addGestureRecognizer:pgr];
    }
    
    return self;
}

static CGFloat _startScale;

- (void)handlePinch:(UIPinchGestureRecognizer *)gr {
    CGFloat scale = [gr scale];
    switch ([gr state]) {
        case UIGestureRecognizerStateBegan:
            self.interactive = YES; _startScale = scale;
            [self.parent popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = (1.0 - scale/_startScale);
            [self updateInteractiveTransition: (percent <= 0.0) ? 0.0 : percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if([gr velocity] >= 0.0 || [gr state] == UIGestureRecognizerStateCancelled)
                [self cancelInteractiveTransition];
            else
                [self finishInteractiveTransition];
            self.interactive = NO;
        break;
        default:
            break;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Animated Transitioning
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    static const CGFloat DampingConstant = 0.75;
    static const CGFloat InitialVelocity = 0.5;
    static const CGFloat PaddingBetweenViews = 20;
    
    UIView * inView = [transitionContext containerView];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * fromView = [fromVC view];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * toView = [toVC view];
    
    inView.backgroundColor = [UIColor blackColor];
    
    CGRect centerRect = [transitionContext finalFrameForViewController:toVC];
    CGRect leftRect = CGRectOffset(centerRect, -(CGRectGetWidth(centerRect)+PaddingBetweenViews), 0);
    CGRect rightRect = CGRectOffset(centerRect, CGRectGetWidth(centerRect)+PaddingBetweenViews, 0);
    
    [inView insertSubview:toView belowSubview:fromView];
    
    
}


@end
