//
//  BEPAirDropTableDataSource.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPAirDropTableDataSource.h"

@implementation BEPAirDropTableDataSource

- (instancetype) initWithTableView:(UITableView*)tv
{
    if (self = [super init])
    {
        tv.dataSource = self;
    }

    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table Data Source
////////////////////////////////////////////////////////////////////////////////////////////////

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

@end
