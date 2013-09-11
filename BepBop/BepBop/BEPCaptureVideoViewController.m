//
//  BEPCaptureVideoViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/10/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPCaptureVideoViewController.h"

@interface BEPCaptureVideoViewController ()

@end

@implementation BEPCaptureVideoViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startVideoCapture:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    
    [self presentViewController:picker animated:YES completion:nil];
}

@end
