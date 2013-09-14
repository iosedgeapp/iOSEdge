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
@property (strong, nonatomic) NSMutableArray* listOfCameras;
@property (nonatomic, assign) CLLocationCoordinate2D  sydneyOperaHouseCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D  bondiBeachCoordinate;
@property (nonatomic, assign) float stepperValue;

@end

@implementation BEPMapViewController
@synthesize listOfCameras, bondiBeachCoordinate, sydneyOperaHouseCoordinate, stepperValue, statusView;

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    sydneyOperaHouseCoordinate = CLLocationCoordinate2DMake(kLAT, kLONG);
    bondiBeachCoordinate = CLLocationCoordinate2DMake(kLATBondi, kLONGBondi);
    CLLocationCoordinate2D  lunaParkCoordinate = CLLocationCoordinate2DMake(kLATLunaPark, kLONGLunaPark);
    
    MKCoordinateRegion sydneyOperaHouseRegion = MKCoordinateRegionMakeWithDistance(sydneyOperaHouseCoordinate, 100, 100);
    MKCoordinateRegion lunaParkRegion = MKCoordinateRegionMakeWithDistance(lunaParkCoordinate, 100, 100);
    
    self.mapView.region = sydneyOperaHouseRegion;
    [self.mapView setShowsPointsOfInterest:YES];
    self.mapView.delegate = self;
    //Annotations    
    MKPointAnnotation *pointOperaHouse = [[MKPointAnnotation alloc] init];
    pointOperaHouse.coordinate = CLLocationCoordinate2DMake(kLAT, kLONG);
    pointOperaHouse.title = @"Sydney Opera House";
    
    MKPointAnnotation *pointBondiBeach = [[MKPointAnnotation alloc] init];
    pointBondiBeach.coordinate = CLLocationCoordinate2DMake(kLATBondi, kLONGBondi);
    pointBondiBeach.title = @"Bondi Beach";
    [self.mapView addAnnotations:@[pointOperaHouse, pointBondiBeach]];
    [self.mapView selectAnnotation:pointOperaHouse animated:YES];
    

    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:sydneyOperaHouseRegion.center  fromEyeCoordinate:lunaParkRegion.center eyeAltitude:900];
    camera.pitch = 60;
    stepperValue = camera.pitch;

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
    


- (void) didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)goToNextCamera{
    if (listOfCameras.count ==0){
        return;
    }
    
    MKMapCamera* nextCamera = [listOfCameras firstObject];
    [listOfCameras removeObject:0];
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.mapView.camera = nextCamera;
                     } completion:NULL];
    
}

- (void)updateStats{
    float altitude = self.mapView.camera.altitude;
    float pitch = self.mapView.camera.pitch;
    float heading = self.mapView.camera.heading;
    float lat = self.mapView.centerCoordinate.latitude;
    float longt = self.mapView.centerCoordinate.longitude;
    
    
    
    
    statusView.text = [NSString stringWithFormat:@"Altitude - %f Heading -%f Pitch -%f, Latitude -%f, Longtitude -%f", altitude, heading, pitch, lat, longt];
}


-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    statusView.hidden = NO;
    
    [self updateStats];
    
    if (animated) //if we are animated go to next camera
        [self goToNextCamera];
}

- (void)goToCoordinate:(CLLocationCoordinate2D)coordionate{
    MKMapCamera* end = [MKMapCamera cameraLookingAtCenterCoordinate:coordionate
                                                   fromEyeCoordinate:coordionate
                                                        eyeAltitude:500];
    end.pitch = 55;
    
    CLLocationCoordinate2D startingCoordinate = self.mapView.centerCoordinate;
    MKMapPoint startingPoint = MKMapPointForCoordinate(startingCoordinate);
    MKMapPoint endPoint = MKMapPointForCoordinate(end.centerCoordinate);
    
    MKMapPoint midPoint = MKMapPointMake(startingPoint.x + ((endPoint.y - startingPoint.y) / 2.0),
                                         startingPoint.y + ((endPoint.y - startingPoint.y) / 2.0)
                                        );
    
    CLLocationCoordinate2D midCoord = MKCoordinateForMapPoint(midPoint);
    
    CLLocationDistance midAltitude = end.altitude * 4; // zoom out 4 times
    
    MKMapCamera* midCamera = [MKMapCamera cameraLookingAtCenterCoordinate:end.centerCoordinate
                                                        fromEyeCoordinate:midCoord
                                                              eyeAltitude:midAltitude];
    
    listOfCameras = [[NSMutableArray alloc] init];
    
    [listOfCameras addObject:midCamera];
    [listOfCameras addObject:end];
    [self goToNextCamera];
    
    
    
    
    
}

- (IBAction)changePitch:(id)sender{
    UISlider* slider = (UISlider*)sender;
    NSLog(@"value %f", slider.value);
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (slider.value < 55.0f)
                         self.mapView.camera.pitch =slider.value;
                     } completion:NULL];

}

- (IBAction)changeCameraView:(id)sender {
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    
    if (segment.selectedSegmentIndex == 0)
        [self goToCoordinate:sydneyOperaHouseCoordinate];
    else
        [self goToCoordinate:bondiBeachCoordinate];
    
}

@end
