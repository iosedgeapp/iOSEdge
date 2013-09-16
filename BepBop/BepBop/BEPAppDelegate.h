//
//  BEPAppDelegate.h
//  BepBop
//
//  Created by Hiedi Utley on 9/1/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

NSUInteger DeviceMajorVersion();
#define IS_IOS_7 (DeviceMajorVersion() == 7)

@interface BEPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;
@property (copy) void (^backgroundSessionCompletionHandler)();

@end
