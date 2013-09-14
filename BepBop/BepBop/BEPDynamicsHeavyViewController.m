//
//  BEPDynamicsHeavyViewController.m
//  BepBop
//
//  Created by mangtronix on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsHeavyViewController.h"

@interface BEPDynamicsHeavyViewController ()

@property (nonatomic, weak) IBOutlet UILabel *heavyLabel;
@property (nonatomic) UIDynamicAnimator *animator;

@end

@implementation BEPDynamicsHeavyViewController

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
	// Do any additional setup after loading the view.

    // Create a basic animator using our view as the reference view
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    UIGravityBehavior *basicGravity = [[UIGravityBehavior alloc] initWithItems:@[self.heavyLabel]];
    [self.animator addBehavior:basicGravity];
    
    // Without any collision behavior, the heavy label would fall right off the screen
    UICollisionBehavior *collideWithBounds = [[UICollisionBehavior alloc] initWithItems:@[self.heavyLabel]];
    collideWithBounds.translatesReferenceBoundsIntoBoundary = YES; // Simple way to make bounds of reference view into a collision boundary
    [self.animator addBehavior:collideWithBounds];

}




@end
