//
//  BEPNavigationTransitionsViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/12/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPNavigationTransitionsViewController.h"

#import "BEPTransitionsMasterViewController.h"

#import "BEPNavigationTransitionsPopAnimator.h"
#import "BEPNavigationTransitionsPushAnimator.h"

@interface BEPNavigationTransitionsViewController ()

@property (nonatomic, weak) id<UINavigationControllerDelegate> previousNavigationDelegate;

@end

@implementation BEPNavigationTransitionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Navigation"
                                                        image:nil
                                                          tag:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // save our navigation controller current delegate, just in case.
    self.previousNavigationDelegate = self.navigationController.delegate;
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.topViewController == self) {
        self.navigationController.delegate = self.previousNavigationDelegate;
        self.previousNavigationDelegate = nil;

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushButtonTapped:(id)sender {
    UIViewController * listVC = [[BEPTransitionsMasterViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:listVC animated:YES];
}
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Navigation Controller Delegate
////////////////////////////////////////////////////////////////////////////////////////////////

- (id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                    animationControllerForOperation:(UINavigationControllerOperation)operation
                                                 fromViewController:(UIViewController *)fromVC
                                                   toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
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
