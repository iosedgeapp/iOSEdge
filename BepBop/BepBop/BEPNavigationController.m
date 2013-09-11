//
//  BEPNavigationController.m
//  BepBop
//
//  Created by Hiedi Utley on 9/10/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPNavigationController.h"

@interface BEPNavigationController ()

@end

@implementation BEPNavigationController
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return (self.topViewController ? self.topViewController.preferredStatusBarStyle : UIStatusBarStyleDefault);
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
