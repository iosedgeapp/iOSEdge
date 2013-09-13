//
//  BEPArrayTableDataSource.m
//  BepBopLibrary
//
//  Created by Engin Kurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPArrayTableDataSource.h"

@interface BEPArrayTableDataSource ()

@property (nonatomic, copy) NSArray * items;
@property (nonatomic, copy) NSString * cellIdentifier;
@property (nonatomic, strong) BEPConfigureCellBlock configureCellBlock;
@end

@implementation BEPArrayTableDataSource

- (instancetype)initWithItems:(NSArray*)items
               cellIdentifier:(NSString*)cellId
               configureBlock:(BEPConfigureCellBlock)block
{
    if (self = [super init]) {
        self.items = items;
        self.cellIdentifier = cellId;
        self.configureCellBlock = block;
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return _items[(NSUInteger)indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    NSAssert(_configureCellBlock, @"cannot configure cells with no configureCellBlock");
    id cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier
                                              forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    _configureCellBlock(cell,item);
    return cell;
}

@end
