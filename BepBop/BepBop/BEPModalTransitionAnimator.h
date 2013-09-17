//
//  BEPModalTransitionAnimator.h
//  BepBop
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, BEPModalTransitionDirection)
{
    BEPModelTransitionDirectionPresent,
    BEPModelTransitionDirectionDismiss
};

@interface BEPModalTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype) initWithDirection:(BEPModalTransitionDirection)direction;


@end
