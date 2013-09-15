//
//  BEPTintedLabelTests.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BEPTintedLabel.h"

#define ORANGE [UIColor orangeColor]
#define BLACK [UIColor blackColor]

@interface BEPTintedLabelTests : XCTestCase
@end

@implementation BEPTintedLabelTests

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
    
    BEPTintedLabel* tintedLabel = [[BEPTintedLabel alloc] init];
    XCTAssertEqualObjects(defaultColor,tintedLabel.tintColor);
    XCTAssertEqualObjects(defaultColor,tintedLabel.textColor);
    
    [view addSubview:tintedLabel];
    XCTAssertEqualObjects(ORANGE,tintedLabel.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedLabel.textColor);
    
    //changing tint color should change the textcolor
    view.tintColor = defaultColor;
    XCTAssertEqualObjects(defaultColor,tintedLabel.tintColor);
    XCTAssertEqualObjects(defaultColor,tintedLabel.textColor);
    
    //set specific tintColor on this label
    tintedLabel.tintColor = ORANGE;
    XCTAssertEqualObjects(ORANGE,tintedLabel.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedLabel.textColor);
    
    //changing tintColor of the view should now have no effect
    view.tintColor = BLACK;
    XCTAssertEqualObjects(ORANGE,tintedLabel.tintColor);
    XCTAssertEqualObjects(ORANGE,tintedLabel.textColor);
    
}


@end
