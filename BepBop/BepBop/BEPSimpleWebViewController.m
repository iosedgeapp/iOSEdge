//
//  BEPSimpleWebViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPSimpleWebViewController.h"

@interface BEPSimpleWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation BEPSimpleWebViewController

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
    if (_url) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:_url]];
        self.title = [_url lastPathComponent];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
