//
//  BEPChapterBarItem.m
//  BepBop
//
//  Created by Michael Ang on 10/18/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPChapterBarItem.h"

@implementation BEPChapterBarItem

+ (BEPChapterBarItem*) barButtonItemForChapter:(NSString *)chapterNumber
{
    UILabel *chapterLabel = [[UILabel alloc] init];
    chapterLabel.text = chapterNumber;
    chapterLabel.font = [UIFont fontWithName:@"Risque-Regular" size:30.0];
    chapterLabel.shadowColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    chapterLabel.shadowOffset = CGSizeMake(-1, 1);
    chapterLabel.backgroundColor = [UIColor clearColor];
    [chapterLabel sizeToFit];
    BEPChapterBarItem *barItem = [[BEPChapterBarItem alloc] initWithCustomView:chapterLabel];
    return barItem;
}

@end
