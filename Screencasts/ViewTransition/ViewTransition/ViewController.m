//
//  ViewController.m
//  ViewTransition
//
//  Created by mangtronix on 12/13/13.
//  Copyright (c) 2013 mangtronix. All rights reserved.
//

#import "ViewController.h"

#import "DismissableViewController.h"
#import "BEPModalTransitionAnimator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showModalTapped:(id)sender
{
    DismissableViewController *imageVC = [[DismissableViewController alloc] init];
    imageVC.modalPresentationStyle = UIModalPresentationCustom;
    imageVC.transitioningDelegate = self;
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController*)presented
presentingController:(UIViewController*)presenting
sourceController:(UIViewController*)source
{
    return [[BEPModalTransitionAnimator alloc] initWithDirection:BEPModelTransitionDirectionPresent];
}

- (id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController*)dismissed
{
    return [[BEPModalTransitionAnimator alloc] initWithDirection:BEPModelTransitionDirectionDismiss];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
