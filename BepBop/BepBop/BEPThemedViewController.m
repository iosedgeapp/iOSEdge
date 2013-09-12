//
//  BEPThemedViewController.m
//  BepBop
//
//  Created by Hiedi Utley on 9/10/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPThemedViewController.h"

@implementation BEPThemedViewController

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }

    BEPTintedLabel* tintedLabel = [[BEPTintedLabel alloc] init];
    tintedLabel.text = self.title;
    [tintedLabel sizeToFit];
    self.navigationItem.titleView = tintedLabel;
}

@end
