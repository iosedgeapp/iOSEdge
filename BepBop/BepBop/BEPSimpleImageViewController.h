//
//  BEPSimpleImageViewController.h
//  BepBop
//
//  Created by Engin Kurutepe on 11/09/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEPSimpleImageViewController : UIViewController

@property (strong, nonatomic) UIImage * image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
