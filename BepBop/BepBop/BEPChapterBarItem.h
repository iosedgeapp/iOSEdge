//
//  BEPChapterBarItem.h
//  BepBop
//
//  Created by Michael Ang on 10/18/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEPChapterBarItem : UIBarButtonItem

+ (BEPChapterBarItem*) barButtonItemForChapter:(NSString*)chapterNumber;

@end
