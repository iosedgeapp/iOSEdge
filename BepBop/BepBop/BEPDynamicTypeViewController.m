//
//  BEPDynamicTypeViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/9/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPDynamicTypeViewController.h"

@interface BEPDynamicTypeViewController ()

@property IBOutlet UILabel *headlineLabel;
@property IBOutlet UILabel *subheadLabel;
@property IBOutlet UILabel *bodyLabel;
@property IBOutlet UILabel *footnoteLabel;

@end

@implementation BEPDynamicTypeViewController

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Chapter 2", nil);
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleContentSizeDidChange:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

- (void) handleContentSizeDidChange:(NSNotification*)aNotification
{
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.subheadLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.footnoteLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
