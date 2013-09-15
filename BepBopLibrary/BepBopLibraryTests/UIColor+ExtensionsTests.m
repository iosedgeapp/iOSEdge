//
//  UIColor+ExtensionsTests.m
//  BepBopLibrary
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIColor+Extensions.h"

@interface UIColor_ExtensionsTests : XCTestCase

@end

@implementation UIColor_ExtensionsTests


- (void) testRandomColor
{

    XCTAssertTrue([[UIColor class] respondsToSelector:@selector(randomColor)]);
    UIColor* color = [UIColor randomColor];
    
    for (NSUInteger i = 0; i < 10; i++) {
        
        UIColor* color2 = [UIColor randomColor];
        XCTAssertNotEqualObjects(color, color2);
        color = color2;
    }
    
}

@end
