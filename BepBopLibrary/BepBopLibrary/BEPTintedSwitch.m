//
//  BEPTintedSwitch.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/11/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPTintedSwitch.h"

@implementation BEPTintedSwitch


- (void) tintColorDidChange
{
    if ([self respondsToSelector:@selector(tintColor)])
    {
        self.onTintColor = self.superview.tintColor;
    }
}

@end
