//
//  BEPSimpleWebViewController.m
//  BepBop
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPSimpleWebViewController.h"

@interface BEPSimpleWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView* webview;

@end

@implementation BEPSimpleWebViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    if (_url)
    {
        [self.webview loadRequest:[NSURLRequest requestWithURL:_url]];
        self.title = [_url lastPathComponent];
        
        UIBarButtonItem * shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                      target:self
                                                                                      action:@selector(presentActivities:)];
        
        self.navigationItem.rightBarButtonItem = shareButton;
    }
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentActivities:(id)sender
{
    UIActivityViewController * activities = [[UIActivityViewController alloc] initWithActivityItems:@[_url]
                                                                              applicationActivities:nil];
    
    [self presentViewController:activities
                       animated:YES
                     completion:nil];
}

@end
