//
//  DismissableImageViewController.m
//  ViewTransition
//
//  Created by mangtronix on 12/13/13.
//  Copyright (c) 2013 mangtronix. All rights reserved.
//

#import "DismissableImageViewController.h"

@interface DismissableImageViewController ()

@end

@implementation DismissableImageViewController

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
    // Do any additional setup after loading the view from its nib.
    
    if (self.image) {
        self.imageView.image = self.image;
    }
}

- (IBAction)dismissTapped:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
