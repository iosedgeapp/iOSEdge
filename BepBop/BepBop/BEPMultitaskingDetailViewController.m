//
//  BEPMultitaskingDetailViewController.m
//  BepBop
//
//  Created by Cody A. Ray on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMultitaskingDetailViewController.h"

@interface BEPMultitaskingDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation BEPMultitaskingDetailViewController
- (IBAction)start:(id)sender {
    [self.masterController insertNewObject];
}

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
//    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://lorempixel.com/400/200/animals/10/"]]];
    self.imageView.hidden = YES;
    [self configureView];
}

- (void)setDetailItem:(BEPMultitaskingListItem *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {

        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil)
        {
            dateFormatter = [[NSDateFormatter alloc] init];
            NSString *dateFormatString = [NSDateFormatter dateFormatFromTemplate:@"eeee d MMMM yyy, hh:mm:ss a" options:0 locale:[NSLocale currentLocale]];
            [dateFormatter setDateFormat:dateFormatString];
        }
        NSLog(@"%@ - %@", self.detailItem.date, self.detailItem.path);
        self.detailDescriptionLabel.text = [dateFormatter stringFromDate:self.detailItem.date];
        if (self.detailItem.path) {
            UIImage *image = [UIImage imageWithContentsOfFile:self.detailItem.path];
            self.imageView.image = image;
            self.imageView.hidden = NO;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
