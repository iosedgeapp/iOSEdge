//
//  BEPNavigationControllerTests.m
//  BepBopTests
//
//  Created by Hiedi Utley on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BEPBaseAppTests.h"

@interface BEPNavigationControllerTests : BEPBaseAppTests

@end

@implementation BEPNavigationControllerTests

- (void) testStatusBarStyle
{
    [self.mainVC selectChapterNumber:0];

    XCTAssertEqual(UIStatusBarStyleLightContent, self.navController.preferredStatusBarStyle);

    [self.mainVC selectChapterNumber:1];

    XCTAssertEqual(UIStatusBarStyleDefault, self.navController.preferredStatusBarStyle);

    [self.mainVC selectChapterNumber:0];

    XCTAssertEqual(UIStatusBarStyleLightContent, self.navController.preferredStatusBarStyle);
}

@end
