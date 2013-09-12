//
//  BEPNavigationTransitionsViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPNavigationTransitionsViewController.h"

#import "BEPSimpleImageViewController.h"

#import "BEPNavigationTransitionsPopAnimator.h"
#import "BEPNavigationTransitionsPushAnimator.h"

@interface BEPNavigationTransitionsViewController ()

@end

@implementation BEPNavigationTransitionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Navigation"
                                                        image:nil
                                                          tag:0];
        self.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    
    if ([self.navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        self.navigationBar.barTintColor = [UIColor lightGrayColor];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.view.bounds = self.tabBarController.view.bounds;
    self.view.center = self.tabBarController.view.center;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"nav frame: %@", NSStringFromCGRect(self.view.frame));

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Navigation Controller Delegate
////////////////////////////////////////////////////////////////////////////////////////////////

- (id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                    animationControllerForOperation:(UINavigationControllerOperation)operation
                                                 fromViewController:(UIViewController *)fromVC
                                                   toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop && fromVC != self.tabBarController) {
        return [[BEPNavigationTransitionsPopAnimator alloc] init];
    }
    else if (operation == UINavigationControllerOperationPush) {
        return [[BEPNavigationTransitionsPushAnimator alloc] init];
    }
    else {
        return nil;
    }
}






@end
