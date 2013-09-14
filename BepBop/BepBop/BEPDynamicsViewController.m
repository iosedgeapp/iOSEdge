//
//  BEPDynamicsViewController.m
//  BepBop
//
//  Created by mangtronix on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsViewController.h"

@interface BEPDynamicsViewController ()

@end

@implementation BEPDynamicsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"UI Dynamics";
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UILabel *hello = [[UILabel alloc] init];
    hello.text = @"Hello world";
    [hello sizeToFit];
    hello.center = CGPointMake(self.view.center.x, 20);
    [self.view addSubview:hello];
    
    UIGravityBehavior *basicGravity = [[UIGravityBehavior alloc] initWithItems:@[hello]];
    [self.animator addBehavior:basicGravity];
    
    UICollisionBehavior *collideWithBounds = [[UICollisionBehavior alloc] initWithItems:@[hello]];
    collideWithBounds.translatesReferenceBoundsIntoBoundary = YES; // Add bounds of reference view as boundary
    [self.animator addBehavior:collideWithBounds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
