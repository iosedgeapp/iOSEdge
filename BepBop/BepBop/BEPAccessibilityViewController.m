//
//  BEPAccessibilityViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPAccessibilityViewController.h"
#import "BEPDynamicTypeViewController.h"
#import "BEPTextToSpeechViewController.h"

@interface BEPAccessibilityViewController ()

@property NSArray* cellTitles;
@property NSArray* viewControllers;

@end

@implementation BEPAccessibilityViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Accessibility", nil);
        self.cellTitles =
            @[NSLocalizedString(@"Dynamic Type", nil),
              NSLocalizedString(@"Text to Speech", nil)];

        self.viewControllers =
            @[[[BEPDynamicTypeViewController alloc] initWithNibName:nil bundle:nil],
              [[BEPTextToSpeechViewController alloc] initWithNibName:nil bundle:nil]];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"CellIdentifier";
    UITableViewCell* cell       = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    cell.textLabel.text = [self.cellTitles objectAtIndex:indexPath.row];

    return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UIViewController* viewController = [self.viewControllers objectAtIndex:indexPath.row];

    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
