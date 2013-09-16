//
//  BEPBaseOCUnitTests.m
//  BepBopOCUnitTests
//
//  Created by Hiedi Utley on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPBaseOCUnitTests.h"

@implementation BEPBaseOCUnitTests

- (void)setUp
{
    [super setUp];
    
    self.appDelegate  = [[UIApplication sharedApplication] delegate];
    self.navController = (id)self.appDelegate.window.rootViewController;
    STAssertTrue([self.navController isMemberOfClass:[BEPNavigationController class]], @"Where's my Nav Controller!!?");
    self.mainVC = (id)self.navController.topViewController;
    STAssertTrue([self.mainVC isMemberOfClass:[BEPMainViewController class]], @"Where's my Main Controller!!?");
    
}

- (void)tearDown
{
    [super tearDown];
    [self.navController popToRootViewControllerAnimated:NO];
    
}

@end
