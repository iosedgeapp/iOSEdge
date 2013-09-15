//
//  BepBopOCUnitTests.m
//  BepBopOCUnitTests
//
//  Created by Hiedi Utley on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface BepBopOCUnitTests : SenTestCase

@end

@implementation BepBopOCUnitTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    UIView* view = [[UIView alloc] init];
    STAssertEquals(0.0f, view.height, @"");
}

@end
