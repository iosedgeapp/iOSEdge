//
//  BEPNavigationTransitionsRootViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPNavigationTransitionsRootViewController.h"

#import "BEPSimpleImageViewController.h"

@interface BEPNavigationTransitionsRootViewController ()

@end

@implementation BEPNavigationTransitionsRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Navigation";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButtonTapped:(id)sender {
    BEPSimpleImageViewController * imageVC = [[BEPSimpleImageViewController alloc] init];
    
    imageVC.image = [UIImage imageNamed:@"Canyon.jpg"];
    
    [self.navigationController pushViewController:imageVC animated:YES];
}

@end
