//
//  BEPLookAndFeelViewController.m
//  BepBop
//
//  Created by Hiedi Utley on 9/10/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPLookAndFeelViewController.h"

@implementation BEPLookAndFeelViewController
{
    @private
    __weak UINavigationController* _navController;
}
- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:@"BEPLookAndFeelView" bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Chapter 1", nil);
    }
    return self;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _navController = self.navigationController;
    [self changeTintColorTo:[UIColor randomColor]];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _navController.view.tintColor = [UIColor blueColor];
    });
    
}

#pragma mark IBActions

-(IBAction)changeTintColor:(id)sender
{
    [self changeTintColorTo:[UIColor randomColor]];
}

-(void) changeTintColorTo:(UIColor*)color
{
    _navController.view.tintColor = color;
}

@end
