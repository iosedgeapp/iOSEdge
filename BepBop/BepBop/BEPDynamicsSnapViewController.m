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
@property (nonatomic) UISnapBehavior*    snapBehavior;

@property (nonatomic, weak) IBOutlet UIView* snapView;
@property (assign) CGFloat damping;

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

    self.damping = 0.5; // Default damping for snapiness

    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
}

- (IBAction) handleSnapGesture:(UITapGestureRecognizer*)gesture
{
    CGPoint point = [gesture locationInView:self.view];

    // Create a new snap behavior
    UISnapBehavior* snapBehavior = [[UISnapBehavior alloc] initWithItem:self.snapView snapToPoint:point];

    snapBehavior.damping = self.damping;

    // If there was a previous snap behavior, remove it
    if (self.snapBehavior)
    {
        [self.animator removeBehavior:self.snapBehavior];
    }

    // Add the new behavior
    [self.animator addBehavior:snapBehavior];
    self.snapBehavior = snapBehavior;
}

- (IBAction) dampingChanged:(id)sender
{
    UISlider* dampingSlider = sender;

    self.damping = dampingSlider.value;
}

@end
