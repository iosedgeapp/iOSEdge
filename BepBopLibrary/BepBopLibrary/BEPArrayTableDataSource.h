//
//  BEPArrayTableDataSource.h
//  BepBopLibrary
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BEPConfigureCellBlock)(UITableViewCell*, id);

@interface BEPArrayTableDataSource : NSObject <UITableViewDataSource>

- (instancetype) initWithItems:(NSArray*)items
                cellIdentifier:(NSString*)cellId
                configureBlock:(BEPConfigureCellBlock)block;

- (id) itemAtIndexPath:(NSIndexPath*)indexPath;

@end
