//
//  BEPDynamicsSpringViewController.m
//  BepBop
//
//  Created by mangtronix on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsSpringViewController.h"

@interface BEPDynamicsSpringViewController ()

@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *attachmentBehavior;

// Shows our touch point
@property (nonatomic, weak) IBOutlet UIView *anchorView;

// The big orange block
@property (nonatomic, weak) IBOutlet UIView *orangeView;
@property (nonatomic, weak) IBOutlet UIView *attachmentView;

@property (nonatomic, weak) IBOutlet UIView *blueView1;
@property (nonatomic, weak) IBOutlet UIView *blueView2;
@property (nonatomic, weak) IBOutlet UIView *blueView3;

@property (nonatomic, assign) UIOffset attachmentOffset;

@end

@implementation BEPDynamicsSpringViewController

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
    
    // Calculate the attachment offset based off the views in the storyboard
    self.attachmentOffset = UIOffsetMake(self.attachmentView.center.x - self.orangeView.width / 2, self.attachmentView.center.y - self.orangeView.height / 2);
    
    // Set up animator
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    // Set up the attachment behavior
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.orangeView offsetFromCenter:self.attachmentOffset attachedToAnchor:self.anchorView.center];
    
    // Make the attachment springy
    attachmentBehavior.damping = 0.4;
    attachmentBehavior.frequency = 1.5;
    
    // Add the attachment behavior
    [self.animator addBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;
    
    // Connect blue views together
    [self connectBlueViews];
    
    // Make blocks collide with each other
    NSArray *coloredBlocks = @[self.orangeView, self.blueView1, self.blueView2, self.blueView3];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:coloredBlocks];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
    
    
    
}

- (void)connectBlueViews
{
    // We offset the connection points to make it more like a "snake"
    UIOffset offsetLeft = UIOffsetMake(-25, 0);
    UIOffset offsetRight = UIOffsetMake(25, 0);
    
    // Connect blue 1 to 2 and add to animator
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView1 offsetFromCenter:offsetRight attachedToItem:self.blueView2 offsetFromCenter:offsetLeft]];
    
    // Attach blue 2 to 3 adn add to animator
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView2 offsetFromCenter:offsetRight attachedToItem:self.blueView3 offsetFromCenter:offsetRight]];
}

- (IBAction)handleAttachmentGesture:(UIPanGestureRecognizer*)gesture
{
    // Get location of touch relative to reference view
    CGPoint touchPoint = [gesture locationInView:self.view];
    
    // Update the anchor point
    [self.attachmentBehavior setAnchorPoint:touchPoint];
    
    // Update the displayed anchor
    self.anchorView.center = touchPoint;
    
}
@end
