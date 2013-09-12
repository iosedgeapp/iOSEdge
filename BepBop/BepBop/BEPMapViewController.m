//
//  BEPMapViewController.m
//  BepBop
//
//  Created by Josh Brown on 9/11/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMapViewController.h"
#import <MapKit/MapKit.h>

@interface BEPMapViewController ()

@property IBOutlet MKMapView *mapView;

@end

@implementation BEPMapViewController

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
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:NO];

    // DEVTODO: put a 3D button on the map?
    
    double latitudeOffset = 0.001; // TODO: play with this number
    CLLocationDegrees latitude = self.mapView.centerCoordinate.latitude - latitudeOffset;
    CLLocationCoordinate2D eyeCoordinate = CLLocationCoordinate2DMake(latitude, self.mapView.centerCoordinate.longitude);
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:self.mapView.centerCoordinate fromEyeCoordinate:eyeCoordinate eyeAltitude:1];
    [self.mapView setCamera:camera animated:NO]; // TODO: animate if desired
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
