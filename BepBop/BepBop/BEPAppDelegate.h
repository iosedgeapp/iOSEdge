//
//  BEPAppDelegate.h
//  BepBop
//
//  Created by Hiedi Utley on 9/1/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.1)

@interface BEPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow* window;

@end
