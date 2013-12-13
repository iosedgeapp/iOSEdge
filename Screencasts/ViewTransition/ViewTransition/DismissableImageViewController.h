//
//  DismissableImageViewController.h
//  ViewTransition
//
//  Created by mangtronix on 12/13/13.
//  Copyright (c) 2013 mangtronix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DismissableImageViewController : UIViewController

@property (strong,nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)dismissTapped:(id)sender;

@end
