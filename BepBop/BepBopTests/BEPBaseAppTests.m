//
//  BEPBaseAppTests.m
//  BepBop
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <XCTest/XCTest.h>
#import"BEPBaseAppTests.h"

@implementation BEPBaseAppTests

- (void) setUp
{
    [super setUp];

    self.appDelegate   = [[UIApplication sharedApplication] delegate];
    self.navController = (id)self.appDelegate.window.rootViewController;
    XCTAssertTrue([self.navController isMemberOfClass:[BEPNavigationController class]]);
    self.mainVC = (id)self.navController.topViewController;
    XCTAssertTrue([self.mainVC isMemberOfClass:[BEPMainViewController class]]);
}

- (void) tearDown
{
    [super tearDown];
    [self.navController popToRootViewControllerAnimated:NO];
}

@end
