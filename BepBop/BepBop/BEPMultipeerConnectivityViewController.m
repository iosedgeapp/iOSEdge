//
//  BEPMultipeerConnectivityViewController.m
//  BepBop
//
//  Created by Engin Kurutepe on 11/09/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMultipeerConnectivityViewController.h"
#import "BEPSimpleImageViewController.h"
#import "BEPAirDropHandler.h"
#import "BEPSimpleWebViewController.h"



@interface BEPMultipeerConnectivityViewController ()

@property (nonatomic, strong) MCAdvertiserAssistant* assistant;
@property (nonatomic, strong) MCSession* session;
@property (nonatomic, strong) MCPeerID*  myPeerID;
@property (nonatomic, strong) MCBrowserViewController* browser;

@property (nonatomic) NSUInteger bytesSent;
@property (nonatomic) NSUInteger bytesReceived;

@property (nonatomic, strong) NSArray * airDropItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) BEPArrayTableDataSource * tableDataSource;
@end

@implementation BEPMultipeerConnectivityViewController

- (void) updateUIState
{
    NSInteger connectedPeerCount = [self.session.connectedPeers count];

    self.peerCountLabel.text = [@(connectedPeerCount)description];

    if (connectedPeerCount > 0)
    {
        self.sendButton.enabled       = YES;
        self.disconnectButton.enabled = YES;
    }
    else
    {
        self.sendButton.enabled       = NO;
        self.disconnectButton.enabled = NO;
    }
}

- (void) updateByteCounters
{
    self.bytesReceivedLabel.text = [@(_bytesReceived)description];
    self.bytesSentLabel.text     = [@(_bytesSent)description];
}

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
    NSString* deviceName = [[UIDevice currentDevice] name];
    self.myPeerID = [[MCPeerID alloc] initWithDisplayName:deviceName];

    _bytesReceived = 0;
    _bytesSent     = 0;

    self.session = [[MCSession alloc] initWithPeer:_myPeerID];

    _session.delegate = self;

    self.assistant = [[MCAdvertiserAssistant alloc] initWithServiceType:BEPMultipeerConnectivityServiceType
                                                          discoveryInfo:nil session:_session];

    _assistant.delegate = self;

    [_assistant start];
    
    BEPConfigureCellBlock configureCell = ^(UITableViewCell* cell, id item) {
        NSURL * url = (NSURL*)item;
        NSLog(@"config cell with URL: %@", url);
        cell.textLabel.text = [url lastPathComponent];
    };
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    NSError * error;
    self.airDropItems = [fm contentsOfDirectoryAtURL:[[BEPAirDropHandler sharedInstance] airDropDocumentsDirectory]
                          includingPropertiesForKeys:nil
                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                               error:&error];
    
    if (_airDropItems == nil) {
        NSLog(@"could not fecth airdrop files: %@", error);
        self.airDropItems = @[];
    }

    static NSString * CellIdentifier = @"AirDropCell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    // tableView.dataSource is a weak property. We need to assign our data source to a strong property to prevent an untimely release
    self.tableDataSource = [[BEPArrayTableDataSource alloc] initWithItems:_airDropItems
                                                           cellIdentifier:CellIdentifier
                                                           configureBlock:configureCell];
    self.tableView.dataSource = _tableDataSource;
    self.tableView.delegate = self;


    [self updateUIState];
}

- (void) dealloc
{
    [_assistant stop];
    [_session disconnect];
    _assistant = nil;
    _session   = nil;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) browseButtonTapped:(UIButton*)sender
{
    NSAssert(_session != nil, @"trying to start browser but our session is nil");

    self.browser = [[MCBrowserViewController alloc] initWithServiceType:BEPMultipeerConnectivityServiceType
                                                                session:_session];

    _browser.delegate = self;

    [self presentViewController:_browser
                       animated:YES
                     completion:nil];
}

- (IBAction) sendButtonTapped:(UIButton*)sender
{
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];

    picker.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    picker.delegate      = self;

    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction) disconnectTapped:(UIButton*)sender
{
    [self.session disconnect];
    _bytesReceived = 0;
    _bytesSent     = 0;
    [self updateByteCounters];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Advertising Assistant Delegate
//////////////////////////////////////////////////////////////////////////////////////////////////

- (void) advertiserAssistantDidDismissInvitation:(MCAdvertiserAssistant*)advertiserAssistant
{
}

- (void) advertiserAssitantWillPresentInvitation:(MCAdvertiserAssistant*)advertiserAssistant
{
}

//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Browser Delegate
//////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL) browserViewController:(MCBrowserViewController*)picker shouldPresentNearbyPeer:(MCPeerID*)peerID withDiscoveryInfo:(NSDictionary*)info
{
    return YES;
}

- (void) browserViewControllerDidFinish:(MCBrowserViewController*)browserViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateUIState];
}

- (void) browserViewControllerWasCancelled:(MCBrowserViewController*)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Session Delegate
//////////////////////////////////////////////////////////////////////////////////////////////


- (void) session:(MCSession*)session peer:(MCPeerID*)peerID didChangeState:(MCSessionState)state
{
    NSLog(@"%@ changed state %d", peerID, state);

    dispatch_async(dispatch_get_main_queue(), ^{
                       [self updateUIState];
                   });
}

- (void) session:(MCSession*)session didReceiveCertificate:(NSArray*)certificate fromPeer:(MCPeerID*)peerID certificateHandler:(void (^)(BOOL accept))certificateHandler
{
    // accept any and all certificates.
    // TODO: don't use in production!
    certificateHandler(YES);
}

- (void) session:(MCSession*)session didStartReceivingResourceWithName:(NSString*)resourceName fromPeer:(MCPeerID*)peerID withProgress:(NSProgress*)progress
{
    NSLog(@"did start downloading \"%@\" from %@", resourceName, peerID.displayName);
}

- (void) session:(MCSession*)session didFinishReceivingResourceWithName:(NSString*)resourceName fromPeer:(MCPeerID*)peerID atURL:(NSURL*)localURL withError:(NSError*)error
{
    NSLog(@"did finish downloading \"%@\" from %@", resourceName, peerID.displayName);
}

- (void) session:(MCSession*)session didReceiveData:(NSData*)data fromPeer:(MCPeerID*)peerID
{
    NSLog(@"did receive %d bytes of data from %@", [data length], peerID.displayName);
    self.bytesReceived += data.length;
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       [self updateByteCounters];
                   });

    NSString* alertTitle       = NSLocalizedString(@"Image Received", @"alert title");
    NSString* alertDescription = [NSString stringWithFormat:
                                  NSLocalizedString(@"Received %d bytes image data from %@", @"alert format"),
                                  [data length], peerID.displayName];

    RIButtonItem* cancelItem = [[RIButtonItem alloc] init];
    cancelItem.label  = NSLocalizedString(@"Dismiss", @"button title");
    cancelItem.action = nil;

    RIButtonItem* openItem = [[RIButtonItem alloc] init];
    openItem.label  = NSLocalizedString(@"Show", @"button title");
    openItem.action = ^{
        UIImage* image = [[UIImage alloc] initWithData:data];

        BEPSimpleImageViewController* sivc = [[BEPSimpleImageViewController alloc] initWithNibName:nil bundle:nil];
        sivc.image = image;

        [self.navigationController pushViewController:sivc animated:YES];
    };

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertDescription
                                           cancelButtonItem:cancelItem
                                           otherButtonItems:openItem, nil];


    dispatch_async(dispatch_get_main_queue(), ^{
                       [alert show];
                   });
}

- (void) session:(MCSession*)session didReceiveStream:(NSInputStream*)stream withName:(NSString*)streamName fromPeer:(MCPeerID*)peerID
{
    NSLog(@"did receive a stream from %@", peerID.displayName);
}

//////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Image Picker Delegate
//////////////////////////////////////////////////////////////////////////////////////////////

- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    UIImage* image     = info[UIImagePickerControllerOriginalImage];
    NSData*  imageData = UIImageJPEGRepresentation(image, 0.5);
    NSError* error     = nil;

    if (![_session sendData:imageData
                    toPeers:_session.connectedPeers
                   withMode:MCSessionSendDataReliable
                      error:&error])
    {
        NSLog(@"could not send data: %@", error);
    }
    else
    {
        self.bytesSent += imageData.length;
        [self updateByteCounters];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table Delegate
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL * url = [self.tableDataSource itemAtIndexPath:indexPath];
    
    if (url) {
        BEPSimpleWebViewController * wvc = [[BEPSimpleWebViewController alloc] initWithNibName:nil bundle:nil];
        
        wvc.url = url;
        
        [self.navigationController pushViewController:wvc animated:YES];
    }
    

}

@end
