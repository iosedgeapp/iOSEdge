//
//  BEPTintedSwitch.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/11/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPTintedSwitch.h"


@implementation BEPTintedSwitch

- (id) init
{
    self = [super init];
    if (self)
    {
        [self prep];
    }
    return self;
}

- (id) initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self prep];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self prep];
    }
    return self;
}

- (void) prep
{
    self.backgroundColor = [UIColor clearColor];
    [self tintColorDidChange];
}

- (void) tintColorDidChange
{
    if ([self respondsToSelector:@selector(tintColor)])
    {
        self.onTintColor = (self.tintColor ? self.tintColor : self.superview.tintColor);
    }
}

- (void) setTintColor:(UIColor*)tintColor
{
    [super setTintColor:tintColor];
    [self tintColorDidChange];
}

@end
