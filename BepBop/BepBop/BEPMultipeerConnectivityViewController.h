//
//  BEPMultipeerConnectivityViewController.h
//  BepBop
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 11/09/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEPThemedViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

#define BEPMultipeerConnectivityServiceType @"bep-demoservice"

@interface BEPMultipeerConnectivityViewController : UIViewController<MCAdvertiserAssistantDelegate,
                                                                            MCBrowserViewControllerDelegate,
                                                                            MCSessionDelegate,
                                                                            UINavigationControllerDelegate, // just to prevent compiler warning.
                                                                            UIImagePickerControllerDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel* peerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel* bytesSentLabel;
@property (weak, nonatomic) IBOutlet UILabel* bytesReceivedLabel;

@property (weak, nonatomic) IBOutlet UIButton* browseButton;
@property (weak, nonatomic) IBOutlet UIButton* sendButton;
@property (weak, nonatomic) IBOutlet UIButton* disconnectButton;
@property (weak, nonatomic) IBOutlet UIButton* sendHelloButton;

- (IBAction) browseButtonTapped:(UIButton*)sender;
- (IBAction) sendButtonTapped:(UIButton*)sender;
- (IBAction) disconnectTapped:(UIButton*)sender;
- (IBAction) sendHelloTapped:(UIButton*)sender;

@end
