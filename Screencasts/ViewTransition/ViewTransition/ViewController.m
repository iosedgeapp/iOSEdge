//
//  ViewController.m
//  ViewTransition
//
//  Created by mangtronix on 12/13/13.
//  Copyright (c) 2013 mangtronix. All rights reserved.
//

#import "ViewController.h"

#import "DismissableImageViewController.h"

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
    DismissableImageViewController *imageVC = [[DismissableImageViewController alloc] init];
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
