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
@property (nonatomic, weak) IBOutlet UIView *touchView;

// The big orange block
@property (nonatomic, weak) IBOutlet UIView *orangeView;
@property (nonatomic, weak) IBOutlet UIView *attachmentView;

@property (nonatomic, weak) IBOutlet UIView *blueView1;
@property (nonatomic, weak) IBOutlet UIView *blueView2;
@property (nonatomic, weak) IBOutlet UIView *blueView3;

@property (nonatomic, weak) IBOutlet UIView *greenView;

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
    UIAttachmentBehavior *touchAttachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.orangeView offsetFromCenter:self.attachmentOffset attachedToAnchor:self.touchView.center];
    
    // Make the attachment springy
    touchAttachmentBehavior.damping = 0.4;
    touchAttachmentBehavior.frequency = 1.5;
    
    // Add the attachment behavior
    [self.animator addBehavior:touchAttachmentBehavior];
    self.attachmentBehavior = touchAttachmentBehavior;
    
    // Connect the blue and green blocks into a "snake" with green tail
    [self connectSnakeViews];
    
    // Make blocks collide with each other
    NSArray *coloredBlocks = @[self.orangeView, self.blueView1, self.blueView2, self.blueView3, self.greenView];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:coloredBlocks];
    
    // Instead of going right to the edges of the view, we inset the boundary
    UIEdgeInsets boundaryInset = UIEdgeInsetsMake(60, 24, 24, 24);
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:boundaryInset];
    
    // Set ourselves as delegate so that we receive collision events
    collisionBehavior.collisionDelegate = self;
    
    // Add the collision behavior to the animator
    [self.animator addBehavior:collisionBehavior];

    // Make the "tail" of the snake light and easier to spin
    UIDynamicItemBehavior *lightBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.greenView]];
    lightBehavior.density = 0.1;
    lightBehavior.angularResistance = 0.1;
    lightBehavior.resistance = 0.1;
    [self.animator addBehavior:lightBehavior];
    
    // Don't let the orange block spin
    UIDynamicItemBehavior *disableRotationBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.orangeView]];
    disableRotationBehavior.allowsRotation = NO;
    [self.animator addBehavior:disableRotationBehavior];
    
}

- (void)connectSnakeViews
{
    // We offset the connection points to make it more like a "snake"
    UIOffset offsetLeft = UIOffsetMake(-25, 0);
    UIOffset offsetRight = UIOffsetMake(25, 0);
    
    // Connect blue 1 to 2 and add to animator
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView1 offsetFromCenter:offsetRight attachedToItem:self.blueView2 offsetFromCenter:offsetLeft]];
    
    // Attach blue 2 to 3 and add to animator
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView2 offsetFromCenter:offsetRight attachedToItem:self.blueView3 offsetFromCenter:offsetLeft]];
    
    // Attach the tail
    [self.animator addBehavior:[[UIAttachmentBehavior alloc] initWithItem:self.blueView3 offsetFromCenter:offsetRight attachedToItem:self.greenView offsetFromCenter:offsetLeft]];
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    // Get location of touch relative to reference view
    CGPoint touchPoint = [gesture locationInView:self.view];
    
    // Update the anchor point
    [self.attachmentBehavior setAnchorPoint:touchPoint];
    
    // Update the displayed anchor
    self.touchView.center = touchPoint;
    
}

#pragma mark CollisionBehaviorDelegate methods

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if (identifier == nil) {
        // Collided with default boundary
        if ([item isKindOfClass:[UIView class]]) {
            UIView *collidedView = (UIView*)item;
            collidedView.alpha = 0.5;
        }
    }
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    if ([item isKindOfClass:[UIView class]]) {
        UIView *collidedView = (UIView*)item;
        collidedView.alpha = 1.0;
    }
}
@end
