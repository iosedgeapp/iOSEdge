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

    // We'll set the color red later when there is an active collision
    self.heavyLabel.textColor = [UIColor greenColor];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *basicGravity = [[UIGravityBehavior alloc] initWithItems:@[self.heavyLabel]];
    [self.animator addBehavior:basicGravity];
    
    // Without any collision behavior, the heavy label would fall right off the screen
    UICollisionBehavior *collideWithBounds = [[UICollisionBehavior alloc] initWithItems:@[self.heavyLabel]];
    collideWithBounds.translatesReferenceBoundsIntoBoundary = YES; // Simple way to make bounds of reference view into a collision boundary
    collideWithBounds.collisionDelegate = self; // So we get callbacks for collisions
    [self.animator addBehavior:collideWithBounds];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollisionBehaviorDelegate methods
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if (item == self.heavyLabel) {
        self.heavyLabel.textColor = [UIColor redColor];
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    if (item == self.heavyLabel) {
        self.heavyLabel.textColor = [UIColor greenColor];
    }
}

@end
