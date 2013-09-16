//
//  BEPLookAndFeelControllerTests.m
//  BepBop
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BEPBaseAppTests.h"
#import "BEPTintedLabel.h"
#import "BEPLookAndFeelViewController.h"

@interface BEPLookAndFeelControllerTests : BEPBaseAppTests

@end

@implementation BEPLookAndFeelControllerTests

- (void) setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void) tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void) testTitle
{
    [self.mainVC selectChapterNumber:0];
    XCTAssertTrue([@"Chapter 1" isEqualToString:self.navController.topViewController.title]);

    BEPLookAndFeelViewController* controller = (id)self.navController.topViewController;

    XCTAssertTrue([controller isMemberOfClass:[BEPLookAndFeelViewController class]]);
}

@end
