//
//  BEPNavigationControllerOCUnitTests.m
//  BepBop
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface BEPNavigationControllerOCUnitTests : BEPBaseOCUnitTests

@end

@implementation BEPNavigationControllerOCUnitTests

- (void) testStatusBarStyle
{
    [self.mainVC selectChapterNumber:0];

    STAssertEquals(UIStatusBarStyleLightContent, self.navController.preferredStatusBarStyle, @"Should be the default style");

    [self.mainVC selectChapterNumber:1];

    STAssertEquals(UIStatusBarStyleDefault, self.navController.preferredStatusBarStyle, @"Should be the themed style");

    [self.mainVC selectChapterNumber:0];

    STAssertEquals(UIStatusBarStyleLightContent, self.navController.preferredStatusBarStyle, @"Should be the default style");
}

@end
