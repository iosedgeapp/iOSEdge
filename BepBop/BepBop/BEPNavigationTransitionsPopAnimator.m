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
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView * inView = [transitionContext containerView];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView * fromView = [fromVC view];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * toView = [toVC view];
    
    inView.backgroundColor = [UIColor blackColor];
    
    CGRect centerRect = [transitionContext initialFrameForViewController:fromVC];
    CGFloat foldWidth = CGRectGetWidth(centerRect)/2;
    CGFloat foldHeight = CGRectGetHeight(centerRect)/2;
    CGFloat yOffset = CGRectGetMinY(centerRect);
    
    UIView * topLeft = [fromView resizableSnapshotViewFromRect:CGRectMake(0, 0, foldWidth, foldHeight)
                                            afterScreenUpdates:NO
                                                 withCapInsets:UIEdgeInsetsZero];
    topLeft.layer.anchorPoint = CGPointMake(1.0, 1.0);
    topLeft.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    topLeft.layer.position = CGPointMake(foldWidth, foldHeight+yOffset);
 
    
    UIView * topRight = [fromView resizableSnapshotViewFromRect:CGRectMake(foldWidth, 0, foldWidth, foldHeight)
                                             afterScreenUpdates:NO
                                                  withCapInsets:UIEdgeInsetsZero];
    topRight.layer.anchorPoint = CGPointMake(0.0, 1.0);
    topRight.layer.position = CGPointMake(foldWidth, foldHeight+yOffset);

    
    UIView * bottomLeft = [fromView resizableSnapshotViewFromRect:CGRectMake(0, foldHeight, foldWidth, foldHeight)
                                               afterScreenUpdates:NO
                                                    withCapInsets:UIEdgeInsetsZero];
    bottomLeft.layer.anchorPoint = CGPointMake(1.0, 0.0);
    bottomLeft.layer.position = CGPointMake(foldWidth, foldHeight+yOffset);

    
    UIView * bottomRight = [fromView resizableSnapshotViewFromRect:CGRectMake(foldWidth, foldHeight, foldWidth, foldHeight)
                                                afterScreenUpdates:NO
                                                     withCapInsets:UIEdgeInsetsZero];
    bottomRight.layer.anchorPoint = CGPointMake(0.0, 0.0);
    bottomRight.layer.position = CGPointMake(foldWidth, foldHeight+yOffset);


    [inView insertSubview:topLeft aboveSubview:fromView];
    [inView insertSubview:topRight aboveSubview:fromView];
    [inView insertSubview:bottomLeft aboveSubview:fromView];
    [inView insertSubview:bottomRight aboveSubview:fromView];
    
    [inView insertSubview:toView belowSubview:fromView];

    fromView.hidden = YES;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext]
                                   delay:0.0
                                 options:0
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.4
                                                                animations:^{
                                                                    CATransform3D firstFolding = CATransform3DMakeRotation(M_PI, 0, 1, 0);
                                                                    topRight.layer.transform = firstFolding;
                                                                    bottomRight.layer.transform = firstFolding;
                                                                    topRight.layer.zPosition = 1;
                                                                    bottomRight.layer.zPosition = 1;
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.4
                                                          relativeDuration:0.4
                                                                animations:^{

                                                                    CATransform3D secondFolding = CATransform3DMakeRotation(M_PI, 1, 0, 0);

                                                                    bottomRight.layer.transform = CATransform3DConcat(bottomRight.layer.transform, secondFolding);
                                                                    
                                                                    bottomRight.layer.zPosition = 2;
                                                                    
                                                                    bottomLeft.layer.transform = secondFolding;
                                                                    
                                                                    bottomLeft.layer.zPosition = 3;

                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.8
                                                          relativeDuration:0.2
                                                                animations:^{
                                                                    topLeft.alpha = 0;
                                                                    topRight.alpha = 0;
                                                                    bottomLeft.alpha = 0;
                                                                    bottomRight.alpha = 0;
                                                                }];
                              }
                              completion:^(BOOL finished) {

                                  if (topLeft.alpha > 0) {
                                      fromView.hidden = NO;
                                      [transitionContext completeTransition:NO];
                                  }
                                  else {
                                      [transitionContext completeTransition:YES];
                                  }
                                  [topLeft removeFromSuperview];
                                  [topRight removeFromSuperview];
                                  [bottomLeft removeFromSuperview];
                                  [bottomRight removeFromSuperview];

                                  
                                  

                              }];
    
    
}


@end
