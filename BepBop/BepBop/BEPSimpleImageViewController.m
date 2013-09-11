//
//  BEPSimpleImageViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 11/09/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPSimpleImageViewController.h"

@interface BEPSimpleImageViewController ()

@end

@implementation BEPSimpleImageViewController

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
    if (_image) {
        self.imageView.image = _image;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
