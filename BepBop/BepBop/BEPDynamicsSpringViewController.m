//
//  BEPDynamicsSpringViewController.m
//  BepBop
//
//  Created by mangtronix on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsSpringViewController.h"

@interface BEPDynamicsSpringViewController ()

@property (nonatomic) UIDynamicAnimator*    animator;
@property (nonatomic) UIAttachmentBehavior* attachmentBehavior;

// Shows our touch point
@property (nonatomic, weak) IBOutlet UIView* touchView;

// The big orange block
@property (nonatomic, weak) IBOutlet UIView* orangeView;
@property (nonatomic, weak) IBOutlet UIView* attachmentView;

@property (nonatomic, weak) IBOutlet UIView* blueView1;
@property (nonatomic, weak) IBOutlet UIView* blueView2;
@property (nonatomic, weak) IBOutlet UIView* blueView3;

@property (nonatomic, weak) IBOutlet UIView* greenView;

@property (nonatomic, assign) UIOffset attachmentOffset;

@end

@implementation BEPDynamicsSpringViewController

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

    // Calculate the attachment offset based off the views in the storyboard
    self.attachmentOffset = UIOffsetMake(self.attachmentView.center.x - self.orangeView.width / 2, self.attachmentView.center.y - self.orangeView.height / 2);

    // Set up animator
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;


    // Don't let the orange block spin
    UIDynamicItemBehavior* disableRotationBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.orangeView]];
    disableRotationBehavior.allowsRotation = NO;
    [self.animator addBehavior:disableRotationBehavior];


    // Connect the blue and green blocks into a "snake" with green tail
    [self connectSnakeViews];

    // Make the "tail" of the snake light and easier to spin
    UIDynamicItemBehavior* lightBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.greenView]];
    lightBehavior.density = 0.1;
    lightBehavior.angularResistance = 0.1;
    lightBehavior.resistance        = 0.1;
    [self.animator addBehavior:lightBehavior];


    // Make blocks collide with each other
    NSArray* coloredBlocks = @[self.orangeView, self.blueView1, self.blueView2, self.blueView3, self.greenView];
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:coloredBlocks];

    // Set up a collision boundary along the bounds of the reference view.
    // Collisions with this boundary will have a nil identifier.
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;

    // Set ourselves as delegate so that we receive collision events
    collisionBehavior.collisionDelegate = self;

    // Add the collision behavior to the animator
    [self.animator addBehavior:collisionBehavior];
}

- (void) connectSnakeViews
{
    // We offset the connection points to make it more like a "snake"
    UIOffset offsetLeft  = UIOffsetMake(-25, 0);
    UIOffset offsetRight = UIOffsetMake(25, 0);

    // Connect blue 1 to 2 and add to animator
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView1 offsetFromCenter:offsetRight attachedToItem:self.blueView2 offsetFromCenter:offsetLeft]];

    // Attach blue 2 to 3 and add to animator
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView2 offsetFromCenter:offsetRight attachedToItem:self.blueView3 offsetFromCenter:offsetLeft]];

    // Attach the tail
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView3 offsetFromCenter:offsetRight attachedToItem:self.greenView offsetFromCenter:offsetLeft]];
}

- (IBAction) handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    // Get location of touch relative to reference view
    CGPoint touchPoint = [gesture locationInView:self.view];

    // Update the anchor point
    [self.attachmentBehavior setAnchorPoint:touchPoint];

    // When starting a drag, we create a new attachment behavior for dragging
    // the orange block and add it to the animator.
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        // Set up the attachment behavior that we'll use to drag the orange block
        UIAttachmentBehavior* touchAttachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.orangeView offsetFromCenter:self.attachmentOffset attachedToAnchor:touchPoint];

        // Make the attachment springy
        touchAttachmentBehavior.damping   = 0.4;
        touchAttachmentBehavior.frequency = 1.5;

        // Add the attachment behavior
        [self.animator addBehavior:touchAttachmentBehavior];
        self.attachmentBehavior = touchAttachmentBehavior;

        // Show that the drag is active
        self.touchView.alpha = 1.0;
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        // The pan ended, so remove the behavior. Let that orange block run free!
        [self.animator removeBehavior:self.attachmentBehavior];
        self.attachmentBehavior = nil;

        // Hide touch point, since drag is not active
        self.touchView.alpha = 0;
    }

    // Update the displayed anchor
    self.touchView.center = touchPoint;
}

#pragma mark CollisionBehaviorDelegate methods

- (void) collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if (identifier == nil)
    {
        // Collided with default boundary, make view lighter
        if ([item isKindOfClass:[UIView class]])
        {
            UIView* collidedView = (UIView*)item;
            collidedView.alpha = 0.5;
        }
    }
}

- (void) collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    // Collision contact ended, make view opaque again
    if ([item isKindOfClass:[UIView class]])
    {
        UIView* collidedView = (UIView*)item;
        collidedView.alpha = 1.0;
    }
}

@end
