//
//  BEPDynamicsSnapViewController.m
//  BepBop
//
//  Created by mangtronix on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsSnapViewController.h"

@interface BEPDynamicsSnapViewController ()

@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UISnapBehavior *snapBehavior;

@property (nonatomic,weak) IBOutlet UIView *snapView;

@end

@implementation BEPDynamicsSnapViewController

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
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
}

- (IBAction)handleSnapGesture:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    
    // Create a new snap behavior
    UISnapBehavior* snapBehavior = [[UISnapBehavior alloc] initWithItem:self.snapView snapToPoint:point];

    // If there was a previous snap behavior, remove it
    if (self.snapBehavior) {
        [self.animator removeBehavior:self.snapBehavior];
    }

    // Add the new behavior
    [self.animator addBehavior:snapBehavior];
    self.snapBehavior = snapBehavior;
}

@end
