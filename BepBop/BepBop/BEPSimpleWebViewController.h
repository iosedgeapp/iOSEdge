//
//  BEPSimpleWebViewController.h
//  BepBop
//
//  Created by Engin Kurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BEPSimpleWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSURL * url;

@end
