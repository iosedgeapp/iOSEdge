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

@property (nonatomic) NSDateFormatter *formatter;

@end

@implementation BEPMultitaskingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Chapter 4", nil);
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"MMM d, h:mm:ss a";
    self.tableView.dataSource = [BEPBackgroundDownloadHandler sharedInstance];
    [self setupRefreshControl];
    [self setupFooter];
}

// this is just t hide the empty rows ~ http://stackoverflow.com/a/6738534/337735
- (void)setupFooter
{
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    emptyView.backgroundColor = [UIColor whiteColor];
    [self.tableView setTableFooterView:emptyView];
}

#pragma mark - Refresh Control

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
}

- (void)refreshControlRequest
{
    [[BEPBackgroundDownloadHandler sharedInstance] refreshWithCompletionHandler:^(BOOL didReceiveNewImage, NSError *error) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [self.formatter stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [self.refreshControl endRefreshing];
}

@end
