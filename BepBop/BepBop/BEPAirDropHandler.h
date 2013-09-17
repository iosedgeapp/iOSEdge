//
//  BEPAirDropHandler.h
//  BepBop
//
//  Created by Engin Kurutepe – https://twitter.com/ekurutepe on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BEPAirDropHandler : NSObject

+ (instancetype) sharedInstance;

- (void) saveAirDropURL:(NSURL*)url;
- (BOOL) moveToLocalDirectoryAirDropURL:(NSURL*)url;
- (NSURL*) airDropDocumentsDirectory;
- (void) handleSavedAirDropURLs;

@end
