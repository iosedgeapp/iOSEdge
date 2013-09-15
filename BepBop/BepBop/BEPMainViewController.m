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

#define kLookAndFeelRow  0
#define kDynamicTypeRow  1
#define kMultipeerRow    2
#define kMultitaskingRow 3
#define kTransitionsRow  5
#define kMapsRow         8

@interface BEPMainViewController ()

@property (nonatomic) NSArray* chapterHeadings;
@property (nonatomic) NSArray* chapterTitles;
@property (nonatomic) NSArray* chapterViewControllerClasses;

@end

@implementation BEPMainViewController

- (id) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
              @"Chapter 9",
              @"Chapter 10",
              @"Chapter 11"];

        self.chapterTitles =
            @[@"iOS 6 App Look and Feel Migration",
              @"Designing accessible interfaces with Dynamic Type",
              @"Direct Wireless Connectivity with Multipeer Networking, AirDrop, and more",
              @"Keeping content up to date while running in the background",
              @"Adding effects to video",
              @"View transition animations",
              @"Animating with gravity and collisions",
              @"Dynamically updating your app snapshot in the App Switcher",
              @"Map directions in 3D",
              @"Taking advantage of the new build improvements",
              @"Unit Testing on Steroids"];

        if (IS_IOS_7) {
            self.chapterViewControllerClasses =
                @[[BEPLookAndFeelViewController class],
                  [BEPAccessibilityViewController class],
                  [BEPMultipeerConnectivityViewController class],
                  [BEPMultitaskingViewController class],
                  [NSNull null],
                  [BEPTabbarTransitionsViewController class],
                  [UIStoryboard class],
                  [NSNull null],
                  [BEPMapViewController class]];
        } else {
            // Most of the examples make use of features exclusively available in iOS7
            self.chapterViewControllerClasses = @[[BEPLookAndFeelViewController class]];
        }
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];


    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Bleeding Edge Press";
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self.chapterViewControllerClasses count]); // On iOS6 only the supported chapters are present
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

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    id viewControllerClass = [self.chapterViewControllerClasses objectAtIndex:indexPath.row];
    if (viewControllerClass != [NSNull null])
    {
        UIViewController* viewController;
        if (viewControllerClass == [UIStoryboard class]) {
            viewController = [[UIStoryboard storyboardWithName:@"BEPDynamicsStoryboard" bundle:nil] instantiateInitialViewController];
        } else {
            viewController = [[viewControllerClass alloc] initWithNibName:nil bundle:nil];
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
