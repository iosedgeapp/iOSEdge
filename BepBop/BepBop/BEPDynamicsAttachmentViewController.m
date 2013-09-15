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
@property (nonatomic, weak) IBOutlet UIView *touchView;

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
    
    // Set up animator
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator = animator;
    
    // By default items are attached at the center. To make things more
    // interesting we offset the drag point to match the position of the blue
    // view. Try changing the position of the blue view in the storyboard to
    // move the attachment point.
    self.attachmentOffset = [self offsetFromCenter:self.attachmentView.center inView:self.orangeView];
    
    // Set up the attachment behavior. The attachment is made between the orange view (offset
    // from the center) to the center of the red view. The attachment anchor point
    // will by updated by our code to follow the finger on the screen.
    CGPoint initialAnchorPoint = self.touchView.center;
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.orangeView offsetFromCenter:self.attachmentOffset attachedToAnchor:initialAnchorPoint];
    [self.animator addBehavior:attachmentBehavior];
    self.attachmentBehavior = attachmentBehavior;

}

- (UIOffset)offsetFromCenter:(CGPoint)point inView:(UIView*)containingView
{
    return UIOffsetMake(point.x - containingView.width / 2,
                        point.y - containingView.height / 2);
}

- (IBAction)handlePanGesture:(UIPanGestureRecognizer*)gesture
{
    // Get location of touch relative to reference view
    CGPoint touchPoint = [gesture locationInView:self.animator.referenceView];
    
    // Update the anchor point
    [self.attachmentBehavior setAnchorPoint:touchPoint];

    // If starting a drag, update the length of the attachment, for a more
    // natural interaction - like dragging a stick starting from the touch point
    if (UIGestureRecognizerStateBegan == gesture.state) {
        self.attachmentBehavior.length = [self distanceBetweenTouchAndAttachmentPoint:touchPoint];
    }
    
    // Update the displayed anchor
    self.touchView.center = touchPoint;
    
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
