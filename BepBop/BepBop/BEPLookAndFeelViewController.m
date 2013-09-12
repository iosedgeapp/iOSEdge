//
//  BEPLookAndFeelViewController.m
//  BepBop
//
//  Created by Hiedi Utley on 9/10/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPLookAndFeelViewController.h"

@implementation BEPLookAndFeelViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:@"BEPLookAndFeelView" bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Chapter 1", nil);
        self.view.tintColor = [UIColor redColor];
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
    [self changeTintColor:nil];

}

#pragma mark IBActions

-(IBAction)changeTintColor:(id)sender
{
    UIColor* color = [UIColor randomColor];
    self.navigationController.navigationBar.tintColor = color;
    self.view.tintColor = color;
    
}


@end
