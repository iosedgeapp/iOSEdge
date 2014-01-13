//
//  ViewController.m
//  Map3D
//
//  Created by mangtronix on 12/13/13.
//  Copyright (c) 2013 mangtronix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create a natural language search request
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    searchRequest.naturalLanguageQuery = @"The Eiffel Tower";
    
    // Create the object that actually does the search
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    
    // Start the search, with a completion block
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        // The Eiffel Tower should be the first map item returned
        if ([[response mapItems] count] > 0) {
            MKMapItem *firstItem = [[response mapItems] firstObject];
            
            // Center the map view on the found coordinate
            CLLocationCoordinate2D eiffelCoordinate = firstItem.placemark.coordinate;
            self.mapView.centerCoordinate = eiffelCoordinate;
            
            MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:eiffelCoordinate fromEyeCoordinate:eiffelCoordinate eyeAltitude:900];
            camera.heading = 135;
            camera.pitch = 75;
            self.mapView.camera = camera;
            
            [UIView animateWithDuration:10 animations:^{
                camera.pitch = 0;
                self.mapView.camera = camera;
            }];


        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
