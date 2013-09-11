//
//  BEPMultipeerConnectivityViewController.h
//  BepBop
//
//  Created by Engin Kurutepe on 11/09/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEPThemedViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

#define BEPMultipeerConnectivityServiceType @"bep-demoservice"

@interface BEPMultipeerConnectivityViewController : BEPThemedViewController
<
    MCAdvertiserAssistantDelegate,
    MCBrowserViewControllerDelegate,
    MCSessionDelegate,
    UINavigationControllerDelegate, // just to prevent compiler warning.
    UIImagePickerControllerDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *peerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bytesSentLabel;
@property (weak, nonatomic) IBOutlet UILabel *bytesReceivedLabel;

@property (weak, nonatomic) IBOutlet UIButton *browseButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

- (IBAction)browseButtonTapped:(UIButton *)sender;
- (IBAction)sendButtonTapped:(UIButton *)sender;
- (IBAction)disconnectTapped:(UIButton *)sender;

@end
