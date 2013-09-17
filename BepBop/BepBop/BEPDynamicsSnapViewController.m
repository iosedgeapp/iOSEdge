//
//  BEPDynamicsSnapViewController.m
//  BepBop
//
//  Created by mangtronix on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsSnapViewController.h"

@interface BEPDynamicsSnapViewController ()

@property (nonatomic) UIDynamicAnimator* animator;
@property (nonatomic) UISnapBehavior* snapBehavior;

// The view that snaps to the touch point
@property (nonatomic, weak) IBOutlet UIView* snappyView;

// Controls the springiness of the snap
@property (nonatomic, weak) IBOutlet UISlider* dampingSlider;

@end

@implementation BEPDynamicsSnapViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Set up the animator using our view as the reference view / coordinate system
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
}

- (IBAction) handleTapGesture:(UITapGestureRecognizer*)tapGesture
{
    CGPoint point = [tapGesture locationInView:self.animator.referenceView];

    // Create a new snap behavior
    UISnapBehavior* snapBehavior = [[UISnapBehavior alloc] initWithItem:self.snappyView snapToPoint:point];

    // The damping controls how springy the snap animation is.  You
    // can play with different damping values by changing the slider.
    snapBehavior.damping = self.dampingSlider.value;

    // If there was a previous snap behavior, remove it
    if (self.snapBehavior)
    {
        [self.animator removeBehavior:self.snapBehavior];
    }

    // Add the new behavior
    [self.animator addBehavior:snapBehavior];
    self.snapBehavior = snapBehavior;
}

@end
