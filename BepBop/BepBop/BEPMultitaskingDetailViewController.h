//
//  BEPMultitaskingDetailViewController.h
//  BepBop
//
//  Created by Cody A. Ray on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEPMultitaskingListItem.h"
#import "BEPMultitaskingMasterViewController.h"

@interface BEPMultitaskingDetailViewController : UIViewController
@property (nonatomic) BEPMultitaskingListItem *detailItem;
@property (nonatomic) BEPMultitaskingMasterViewController *masterController;
@end
