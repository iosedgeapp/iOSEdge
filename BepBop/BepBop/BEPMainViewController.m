//
//  BEPMainViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/9/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMainViewController.h"
#import "BEPLookAndFeelViewController.h"
#import "BEPAccessibilityViewController.h"
#import "BEPMultipeerConnectivityViewController.h"
#import "BEPMultitaskingViewController.h"
#import "BEPMapViewController.h"
#import "BEPTabbarTransitionsViewController.h"
#import "BEPChapterBarItem.h"

#import "MTImageMapView.h"

typedef UIViewController* (^ViewControllerBlock)();

@interface BEPMainViewController ()

@property NSArray* chapterHeadings;
@property NSArray* chapterTitles;

@end

@implementation BEPMainViewController

- (id) init
{
    self = [super init];
    if (self)
    {
        self.chapterHeadings =
            @[@"Chapter 1",
              @"Chapter 2",
              @"Chapter 3",
              @"Chapter 4",
              @"Chapter 5",
              @"Chapter 6",
              @"Chapter 7",
              @"Chapter 8",
              @"Chapter 9"];

        self.chapterTitles =
            @[@"Look and Feel: iOS 6 to 7",
              @"Dynamic Animations with a Physical Feel",
              @"View Transition Animations",
              @"Multitasking in iOS 7",
              @"Airdrop and Multipeer Connectivity",
              @"Map Directions in 3D",
              @"Accessibility in iOS 7",
              @"Build Improvements and Continuous Integration",
              @"Unit Testing on Steroids"];

        if (IS_IOS_7)
        {
            self.chapterViewControllerCreationBlocks =
                @[
                   ^{ return [[BEPLookAndFeelViewController alloc] init]; },
                   ^{ return [[UIStoryboard storyboardWithName:@"BEPDynamicsStoryboard" bundle:nil] instantiateInitialViewController]; },
                    ^{ return [[BEPTabbarTransitionsViewController alloc] init]; },
                    ^{ return [[BEPMultitaskingViewController alloc] initWithStyle:UITableViewStylePlain]; },
                    ^{ return [[BEPMultipeerConnectivityViewController alloc] initWithNibName:nil bundle:nil]; },
                    ^{ return [[BEPMapViewController alloc] initWithNibName:nil bundle:nil]; },
                    ^{ return [[BEPAccessibilityViewController alloc] initWithNibName:nil bundle:nil]; },
                    // ^{ return [NSNull null]; }, // TODO implement
                    // ^{ return [NSNull null]; }  // TODO implement
                ];
        }
        else
        {
            // Most of the examples make use of features exclusively available in iOS7
            self.chapterViewControllerCreationBlocks = @[
                    ^{ return [[BEPLookAndFeelViewController alloc] init]; }
                ];
        }
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // Load TOC map image view - varies on iOS version and screen size
    BOOL belowOS7 = [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending;
        
    NSString *imageName = @"TOC";
    if (belowOS7) {
        imageName = @"iOS6-TOC";
    }
    
    NSString *touchPointsName = @"toc_points";
    if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
        imageName = [imageName stringByAppendingString:@"-568"];
        touchPointsName = @"toc_points_568";
    }
    MTImageMapView *imageMapView = [[MTImageMapView alloc] initWithImage:[UIImage imageNamed:imageName]];
    NSArray *touchPoints = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:touchPointsName ofType:@"plist"]];
    [imageMapView setMapping:touchPoints doneBlock:nil];
    imageMapView.delegate = self;
    [self.view addSubview:imageMapView];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = NSLocalizedString(@"Table of Contents", nil);
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark MTImageMapViewDelegate
- (void) imageMapView:(MTImageMapView *)inImageMapView didSelectMapArea:(NSUInteger)inIndexSelected
{
    [self selectChapterNumber:inIndexSelected];
}

#pragma mark - UITableViewController

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self.chapterViewControllerCreationBlocks count]); // On iOS6 only the supported chapters are present
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"CellIdentifier";
    UITableViewCell* cell       = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }

    cell.textLabel.text       = [self.chapterHeadings objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.chapterTitles objectAtIndex:indexPath.row];

    return cell;
}

// Creates the view controller for a chapter
- (UIViewController*) chapterViewControllerForIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.row >= [self.chapterViewControllerCreationBlocks count]) {
        // Invalid chapter
        return nil;
    }
    // Get the block used to create the controller, and call it!
    ViewControllerBlock createViewController = self.chapterViewControllerCreationBlocks[indexPath.row];
    UIViewController *viewController = createViewController();
    
    // Custom chapter number on right hand side
    NSInteger chapterNumber = indexPath.row + 1;
    if (chapterNumber > 1) {
        viewController.navigationItem.rightBarButtonItem = [BEPChapterBarItem barButtonItemForChapter:[NSString stringWithFormat:@"%d", indexPath.row + 1]];
    }
    
    return viewController;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [self selectChapterNumber:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) selectChapterNumber:(NSUInteger)chapterNumber
{
    UIViewController* chapterViewController;

    chapterViewController = [self chapterViewControllerForIndexPath:[NSIndexPath indexPathForRow:chapterNumber inSection:0]];

    if ([chapterViewController isKindOfClass:[UIViewController class]])
    {
        [self.navigationController pushViewController:chapterViewController animated:YES];
    }
}

@end
