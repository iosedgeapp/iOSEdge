//
//  BEPMapViewController.m
//  BepBop
//
//  Created by Doron Katz on 9/11/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMapViewController.h"
#import <MapKit/MapKit.h>


#define kLAT -33.85822
#define kLONG 151.21493

#define kLATBondi -33.8910
#define kLONGBondi 151.2777

#define kLATLunaPark -33.8482
#define kLONGLunaPark 151.2100

@interface BEPMapViewController ()

@property IBOutlet MKMapView *mapView;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    CLLocationCoordinate2D  sydneyOperaHouseCoordinate = CLLocationCoordinate2DMake(kLAT, kLONG);
    CLLocationCoordinate2D  bondiBeachCoordiante = CLLocationCoordinate2DMake(kLATBondi, kLONGBondi);
    CLLocationCoordinate2D  lunaParkCoordinate = CLLocationCoordinate2DMake(kLATLunaPark, kLONGLunaPark);
    
    MKCoordinateRegion sydneyOperaHouseRegion = MKCoordinateRegionMakeWithDistance(sydneyOperaHouseCoordinate, 100, 100);
    MKCoordinateRegion bondiBeachRegion = MKCoordinateRegionMakeWithDistance(bondiBeachCoordiante, 100, 100);
    MKCoordinateRegion lunaParkRegion = MKCoordinateRegionMakeWithDistance(lunaParkCoordinate, 100, 100);
    
    self.mapView.region = sydneyOperaHouseRegion;
    //Annotations    
    MKPointAnnotation *pointOperaHouse = [[MKPointAnnotation alloc] init];
    pointOperaHouse.coordinate = CLLocationCoordinate2DMake(kLAT, kLONG);
    pointOperaHouse.title = @"Sydney Opera House";
    
    MKPointAnnotation *pointBondiBeach = [[MKPointAnnotation alloc] init];
    pointBondiBeach.coordinate = CLLocationCoordinate2DMake(kLATBondi, kLONGBondi);
    pointBondiBeach.title = @"Bondi Beach";
    [self.mapView addAnnotations:@[pointOperaHouse, pointBondiBeach]];
    [self.mapView selectAnnotation:pointOperaHouse animated:YES];
    
    //[self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    //[self.mapView setCenterCoordinate:sydneyOperaHouseCoordinate animated:NO];
    
    
    //Map Camera
    
    //Centre Coordinate - Point on ground
    
    //Altitude - Height above map
    
    //Heading - Direction camera faces
    
    //Pitch - Angle camera tilts
    
    
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:sydneyOperaHouseRegion.center  fromEyeCoordinate:lunaParkRegion.center eyeAltitude:900];
    camera.pitch = 60;
    //camera.altitude = 1500;
    [self.mapView setCamera:camera animated:NO];

    
}



#pragma mark Storing and Restoring State


-(void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    MKMapCamera* camera = [self.mapView camera];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString* docFile = [docDir stringByAppendingPathComponent: @"BepBopMap.plist"];
    
    [NSKeyedArchiver archiveRootObject:camera toFile:docFile];
  
    [super encodeRestorableStateWithCoder:coder];
}


    
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex: 0];
        NSString* docFile = [docDir stringByAppendingPathComponent: @"BepBopMap.plist"];
        
        MKMapCamera* camera = [NSKeyedUnarchiver unarchiveObjectWithFile: docFile];
        [self.mapView setCamera:camera];
        
        [super decodeRestorableStateWithCoder:coder];
    }
    
    
- (void)didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
