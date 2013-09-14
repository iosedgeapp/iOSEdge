//
//  BEPTabbarTransitionsViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPTabbarTransitionsViewController.h"
#import "BEPPresentationTransitionsViewController.h"
#import "BEPNavigationTransitionsViewController.h"
#import "BEPNavigationTransitionsRootViewController.h"

@interface BEPTabbarTransitionsViewController ()

@end

@implementation BEPTabbarTransitionsViewController

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.delegate = self;

    UIViewController* root = [[BEPNavigationTransitionsRootViewController alloc] initWithNibName:nil bundle:nil];

    NSArray* vcs = @[
            [[BEPPresentationTransitionsViewController alloc] initWithNibName:nil bundle:nil],
            [[BEPNavigationTransitionsViewController alloc] initWithRootViewController:root]
        ];



    [self setViewControllers:vcs
                    animated:NO];

    self.selectedIndex = 0;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Tab Bar Controller Delegate
////////////////////////////////////////////////////////////////////////////////////////////////

- (id <UIViewControllerAnimatedTransitioning>) tabBarController:(UITabBarController*)tabBarController
             animationControllerForTransitionFromViewController:(UIViewController*)fromVC
                                               toViewController:(UIViewController*)toVC
{
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Animated Transitioning
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    static const CGFloat DampingConstant     = 0.75;
    static const CGFloat InitialVelocity     = 0.5;
    static const CGFloat PaddingBetweenViews = 20;

    UIView* inView = [transitionContext containerView];
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* fromView         = [fromVC view];
    UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* toView = [toVC view];

    inView.backgroundColor = [UIColor blackColor];

    CGRect centerRect = [transitionContext finalFrameForViewController:toVC];
    CGRect leftRect   = CGRectOffset(centerRect, -(CGRectGetWidth(centerRect)+PaddingBetweenViews), 0);
    CGRect rightRect  = CGRectOffset(centerRect, CGRectGetWidth(centerRect)+PaddingBetweenViews, 0);


    if (fromVC == self.viewControllers[0]) // we are transitioning from the first VC to the second
    {
        toView.frame = rightRect;

        [inView addSubview:toView];

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:DampingConstant
              initialSpringVelocity:InitialVelocity
                            options:0
                         animations:^{
             fromView.frame = leftRect;
             toView.frame = centerRect;
         }
                         completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
         }];
    }
    else if (fromVC == self.viewControllers[1]) // we are transitioning from the second VC to the first
    {
        toView.frame = leftRect;
        [inView addSubview:toView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0.0
             usingSpringWithDamping:DampingConstant
              initialSpringVelocity:-InitialVelocity
                            options:0
                         animations:^{
             fromView.frame = rightRect;
             toView.frame = centerRect;
         }
                         completion:^(BOOL finished) {
             [transitionContext completeTransition:YES];
         }];
    }
}

- (void) animationEnded:(BOOL)transitionCompleted
{
}

@end
