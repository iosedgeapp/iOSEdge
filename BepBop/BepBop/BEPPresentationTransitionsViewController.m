//
//  BEPPresentationTransitionsViewController.m
//  BepBop
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPPresentationTransitionsViewController.h"
#import "BEPSimpleImageViewController.h"
#import "BEPModalTransitionAnimator.h"

@interface BEPPresentationTransitionsViewController ()

@end

@implementation BEPPresentationTransitionsViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Presentation";
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) presentTapped:(UIButton*)sender
{
    UIButton* removeButton = [[UIButton alloc] initWithFrame:self.navigationController.view.bounds];

    [removeButton addTarget:self
                     action:@selector(dismissPhoto:)
           forControlEvents:UIControlEventTouchUpInside];

    removeButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];

    [self.navigationController.view addSubview:removeButton];

    BEPSimpleImageViewController* ivc = [[BEPSimpleImageViewController alloc] init];
    ivc.image = [UIImage imageNamed:@"Canyon.jpg"];
    ivc.modalPresentationStyle = UIModalPresentationCustom;
    ivc.transitioningDelegate = self;
    [self presentViewController:ivc animated:YES completion:nil];
}

- (void) dismissPhoto:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
         [sender removeFromSuperview];
     }];
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Transition Delegate
////////////////////////////////////////////////////////////////////////////////////////////////

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

@end
