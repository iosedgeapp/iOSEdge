//
//  BEPNavigationTransitionsPopAnimator.h
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEPNavigationTransitionsPopAnimator : UIPercentDrivenInteractiveTransition <
UIViewControllerAnimatedTransitioning
>

- (instancetype)initWithNavigationController:(UINavigationController *)nc;

@property(nonatomic,weak) UINavigationController *parent;
@property(nonatomic,getter = isInteractive) BOOL interactive;

@end
