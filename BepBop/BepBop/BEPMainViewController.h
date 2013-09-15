//
//  BEPMainViewController.h
//  BepBop
//
//  Created by Josh Brown on 9/9/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLookAndFeelRow  0
#define kDynamicTypeRow  1
#define kMultipeerRow    2
#define kMultitaskingRow 3
#define kTransitionsRow  5
#define kMapsRow         8

@interface BEPMainViewController : UITableViewController

@property NSMutableDictionary* chapterViewControllers;
@property NSArray* chapterViewControllerCreationBlocks;

@end
