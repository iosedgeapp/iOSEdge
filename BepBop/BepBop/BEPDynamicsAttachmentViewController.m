//
//  BEPDynamicsAttachmentViewController.m
//  BepBop
//
//  Created by mangtronix on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicsAttachmentViewController.h"

@interface BEPDynamicsAttachmentViewController ()

@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *attachmentBehavior;

@property (nonatomic, weak) IBOutlet UIView *orangeView;
@property (nonatomic, weak) IBOutlet UIView *attachmentView;
@property (nonatomic, weak) IBOutlet UIView *anchorView;

@property (nonatomic, assign) UIOffset attachmentOffset;

@end

@implementation BEPDynamicsAttachmentViewController

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
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] init];
    self.animator = animator;
    
    // Set up the attachment behavior
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.orangeView offsetFromCenter:self.attachmentOffset attachedToAnchor:self.anchorView.center];
    [self.animator addBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;

}

- (IBAction)handleAttachmentGesture:(UIPanGestureRecognizer*)gesture
{
    // Get location of touch relative to reference view
    CGPoint touchPoint = [gesture locationInView:self.view];

    // Update the anchor point
    [self.attachmentBehavior setAnchorPoint:touchPoint];
    
    // If starting a drag, update the length of the attachment, for a more
    // natural interaction - like dragging a stick starting from the touch point
    if (UIGestureRecognizerStateBegan == gesture.state) {
        self.attachmentBehavior.length = [self distanceBetweenTouchAndAttachmentPoint:touchPoint];
    }
    
    // Update the displayed anchor
    self.anchorView.center = touchPoint;
    
}

- (CGFloat)distanceBetweenTouchAndAttachmentPoint:(CGPoint)touchPoint
{
    // Get the location of the attachment point (the center of the blue square)
    // relative to the reference view
    CGPoint attachmentPoint = [self.view convertPoint:self.attachmentView.center fromView:self.orangeView];

    CGFloat xDist = (touchPoint.x - attachmentPoint.x);
    CGFloat yDist = (touchPoint.y - attachmentPoint.y);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist)); // Pythagoras
    return distance;
}

@end
