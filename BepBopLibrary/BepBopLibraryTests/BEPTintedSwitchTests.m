//
//  BEPTintedSwitchTests.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BEPTintedSwitch.h"

#define ORANGE [UIColor orangeColor]
#define BLACK [UIColor blackColor]

@interface BEPTintedSwitchTests : XCTestCase
@end

@implementation BEPTintedSwitchTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    
    [super tearDown];
}

- (void) testTintColor
{
    UIView* view = [[UIView alloc] init];
    UIColor* defaultColor = view.tintColor;
    view.tintColor = ORANGE;
    XCTAssertEqualObjects(ORANGE, view.tintColor);
    
    BEPTintedSwitch* tintedSwitch = [[BEPTintedSwitch alloc] init];
    XCTAssertNil(tintedSwitch.tintColor);
    XCTAssertNil(tintedSwitch.onTintColor);
    
    [view addSubview:tintedSwitch];
    //tintColor stays as nil. so we use the tint from the switches superview
    XCTAssertNil(tintedSwitch.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedSwitch.superview.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedSwitch.onTintColor);
    
    //changing tint color should change the switch onTintColor
    view.tintColor = defaultColor;
    XCTAssertEqualObjects(defaultColor,tintedSwitch.onTintColor);
    XCTAssertEqualObjects(defaultColor,tintedSwitch.superview.tintColor);

    //set specific tintColor on this switch
    tintedSwitch.tintColor = ORANGE;
    XCTAssertEqualObjects(ORANGE,tintedSwitch.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedSwitch.onTintColor);
    
    //changing tintColor of the view should now have no effect
    view.tintColor = BLACK;
    XCTAssertEqualObjects(ORANGE,tintedSwitch.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedSwitch.onTintColor);
    
}


@end
