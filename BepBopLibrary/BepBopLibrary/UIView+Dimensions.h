//
//  UIView+Dimensions.h
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/1/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Dimensions)

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

// Convenience
- (void) setHeight:(CGFloat)height;
- (void) setWidth:(CGFloat)width;
- (void) setWidth:(CGFloat)width height:(CGFloat)height;
- (void) setSize:(CGSize)size;

@end
