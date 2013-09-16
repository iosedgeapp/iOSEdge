//
//  BEPBaseOCUniTests.h
//  BepBop
//
//  Created by Hiedi Utley on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "BEPAppDelegate.h"
#import "BEPNavigationController.h"
#import "BEPMainViewController.h"

@interface BEPBaseOCUnitTests : SenTestCase
@property (nonatomic, strong) BEPAppDelegate* appDelegate;
@property (nonatomic, strong) BEPNavigationController* navController;
@property (nonatomic, strong) BEPMainViewController* mainVC;

@end

