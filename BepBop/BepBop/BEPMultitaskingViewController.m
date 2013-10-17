//
//  BEPMultitaskingViewController.m
//  BepBop
//
//  Created by Cody A. Ray on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMultitaskingViewController.h"
#import "BEPBackgroundDownloadHandler.h"

@interface BEPMultitaskingViewController ()

@property (nonatomic) NSDateFormatter* formatter;

@end

@implementation BEPMultitaskingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"MMM d, h:mm:ss a";

    self.title = NSLocalizedString(@"Multitasking", nil);
    self.tableView.dataSource      = [BEPBackgroundDownloadHandler sharedInstance];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)]; // hide empty rows ~ http://stackoverflow.com/a/6738534/337735

    [self setupRefreshControl];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transferComplete:) name:@"BackgroundTransferComplete" object:nil];
}

#pragma mark - Refresh Control

- (void) setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
}

- (void) refreshControlRequest
{
    [[BEPBackgroundDownloadHandler sharedInstance] refreshWithCompletionHandler:^(BOOL didReceiveNewImage, NSError* error) {
         if (didReceiveNewImage)
         {
             NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
             [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
             NSString* lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [self.formatter stringFromDate:[NSDate date]]];
             self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
         }
         [self.refreshControl endRefreshing];
     }];
}

#pragma mark - Notifications

- (void) transferComplete:(NSNotification*)notification
{
    int row = [[[notification userInfo] objectForKey:@"id"] integerValue];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:0];

    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
