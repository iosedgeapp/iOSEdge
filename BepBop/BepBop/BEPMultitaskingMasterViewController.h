//
//  BEPMultitaskingMasterViewController.h
//  BepBop
//
//  Created by Cody A. Ray on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEPMultitaskingMasterViewController : UITableViewController

- (void)performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
