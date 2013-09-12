//
//  BEPTintedLabel.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/11/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPTintedLabel.h"
#import "UIView+Dimensions.h"

@implementation BEPTintedLabel

-(void)tintColorDidChange
{
    self.textColor = self.tintColor;
}

@end
