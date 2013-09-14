//
//  UIView+Dimensions.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/1/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "UIView+Dimensions.h"

@implementation UIView (Dimensions)

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth:(CGFloat)width
{
    CGRect frame = self.frame;

    frame.size.width = width;
    self.frame       = frame;
}

- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize:(CGSize)size
{
    CGRect frame = self.frame;

    frame.size = size;
    self.frame = frame;
}

- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight:(CGFloat)height
{
    CGRect frame = self.frame;

    frame.size.height = height;
    self.frame        = frame;
}

- (void) setWidth:(CGFloat)width height:(CGFloat)height
{
    CGRect frame = self.frame;

    frame.size.height = height;
    frame.size.width  = width;
    self.frame        = frame;
}

@end
