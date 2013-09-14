//
//  BEPMapViewController.h
//  BepBop
//
//  Created by Doron Katz on 9/11/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface BEPMapViewController : UIViewController <MKMapViewDelegate>
- (IBAction)changePitch:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *statusView;
- (IBAction)changeCameraView:(id)sender ;
@end
