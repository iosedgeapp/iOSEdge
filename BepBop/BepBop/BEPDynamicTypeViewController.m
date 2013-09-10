//
//  BEPDynamicTypeViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/9/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicTypeViewController.h"

@interface BEPDynamicTypeViewController ()

@property UILabel *headlineLabel;
@property UILabel *bodyLabel;

@end

@implementation BEPDynamicTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Chapter 2", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 300, 60)];
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.headlineLabel.text = @"Apple announces iPhone 5S";
    [self.view addSubview:self.headlineLabel];
    
    self.bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 300, 200)];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.bodyLabel.numberOfLines = 0;
    self.bodyLabel.text =
    @"Today Apple unveiled the iPhone 5S, their latest addition to the iPhone line."
    " Sporting a fingerprint scanner, improved rear camera, and a new gold/champagne color option,"
    " Apple is calling this \"the most amazing iPhone yet.\"";
    [self.view addSubview:self.bodyLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleContentSizeDidChange:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)handleContentSizeDidChange:(NSNotification *)aNotification
{
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
