//
//  BEPAirDropHandler.m
//  BepBop
//
//  Created by Engin Kurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPAirDropHandler.h"

@implementation BEPAirDropHandler

#define BEPDefaultsStoredAirDropURLsKey @"BEPDefaultsStoredAirDropURLsKey"

+ (instancetype)sharedInstance {
    static BEPAirDropHandler * __sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BEPAirDropHandler alloc] init];
    });
    
    return __sharedInstance;
}

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - AirDrop File Handling
////////////////////////////////////////////////////////////////////////////////////////////////


- (void)saveAirDropURL:(NSURL *)url
{
    // we dont' have access to the file let's just remember the url for later handling
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray * currentStoredURLs = [defaults arrayForKey:BEPDefaultsStoredAirDropURLsKey];
    
    if (currentStoredURLs == nil) {
        currentStoredURLs = @[];
    }
    
    NSArray * updatedStoredURLs = [currentStoredURLs arrayByAddingObject:url];
    
    [defaults setObject:updatedStoredURLs forKey:BEPDefaultsStoredAirDropURLsKey];
    
    [defaults synchronize];
}

- (BOOL)moveToLocalDirectoryAirDropURL:(NSURL *)url
{
    NSFileManager * fm = [NSFileManager defaultManager];
    
    NSURL * localUrl = [[self airDropDocumentsDirectory] URLByAppendingPathComponent:[url lastPathComponent]];
    NSError * error;
    BOOL ret = [fm moveItemAtURL:url
                           toURL:localUrl
                           error:&error];
    
    if (!ret) {
        NSLog(@"could not move file from %@ to %@: %@", url, localUrl, error);
    }
    
    return ret;
}

- (NSURL*)airDropDocumentsDirectory
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSURL * documentsDirectory = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSURL * airDropDirectory = [documentsDirectory URLByAppendingPathComponent:@"AirDrop"];
    
    NSError * error;
    if (![fm createDirectoryAtURL:airDropDirectory
      withIntermediateDirectories:YES
                       attributes:nil
                            error:&error]) {
        NSLog(@"couldn not create %@: %@", airDropDirectory, error);
        return nil;
    }
    
    return airDropDirectory;
    
}

- (void)handleSavedAirDropURLs
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray * currentStoredURLs = [defaults arrayForKey:BEPDefaultsStoredAirDropURLsKey];
    
    if ([currentStoredURLs count]) {
        NSMutableArray * unsavedURLs = [NSMutableArray arrayWithCapacity:[currentStoredURLs count]];
        for (NSURL * url in currentStoredURLs) {
            if (![self moveToLocalDirectoryAirDropURL:url]) {
                [unsavedURLs addObject:url];
            }
        }
        
        [defaults setObject:[NSArray arrayWithArray:unsavedURLs]
                     forKey:BEPDefaultsStoredAirDropURLsKey];
        
        [defaults synchronize];
    }
}

@end
