//
//  UIView+DimensionsTests.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#define HEIGHT (100.0f)
#define WIDTH (200.0f)

#import <XCTest/XCTest.h>
#import "UIView+Dimensions.h"
@interface UIView_DimensionsTests : XCTestCase

@end

@implementation UIView_DimensionsTests

- (void) testHeight
{
    UIView* view = [[UIView alloc] init];
    
    XCTAssertTrue([view respondsToSelector:@selector(height)]);
    XCTAssertTrue([view respondsToSelector:@selector(setHeight:)]);

    XCTAssertEqual(0.0f, view.height);
    view.height = HEIGHT;
    XCTAssertEqual(HEIGHT, view.height);
}

- (void) testWidth {
    UIView* view = [[UIView alloc] init];
    
    XCTAssertTrue([view respondsToSelector:@selector(width)]);
    XCTAssertTrue([view respondsToSelector:@selector(setWidth:)]);
    
    XCTAssertEqual(0.0f, view.width);
    view.width = WIDTH;
    XCTAssertEqual(WIDTH, view.width);
}

- (void) testSize {
    UIView* view = [[UIView alloc] init];
    
    XCTAssertTrue([view respondsToSelector:@selector(size)]);
    XCTAssertTrue([view respondsToSelector:@selector(setSize:)]);
    
    XCTAssertEqual(0.0f, view.size.width);
    XCTAssertEqual(0.0f, view.size.height);

    view.size = CGSizeMake(WIDTH, HEIGHT);
    
    XCTAssertEqual(WIDTH, view.size.width);
    XCTAssertEqual(HEIGHT, view.size.height);
    XCTAssertEqual(WIDTH, view.width);
    XCTAssertEqual(HEIGHT, view.height);
}

@end
