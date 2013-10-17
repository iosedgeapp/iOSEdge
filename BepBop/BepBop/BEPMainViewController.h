//
//  BEPMainViewController.h
//  BepBop
//
//  Created by Josh Brown on 9/9/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTImageMapView.h"

@interface BEPMainViewController : UIViewController <MTImageMapDelegate>

@property NSArray* chapterViewControllerCreationBlocks;

- (void) selectChapterNumber:(NSUInteger)chapterNumber;

@end
