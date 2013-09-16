//
//  BEPBackgroundDownloadHandler.h
//  BepBop
//
//  Created by Cody A. Ray on 9/15/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BEPRefreshCompletionHandler)(BOOL didReceiveNewImage, NSError* error);

@interface BEPBackgroundDownloadHandler : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate, UITableViewDataSource>

+ (instancetype) sharedInstance;

- (void) refreshWithCompletionHandler:(BEPRefreshCompletionHandler)completionHandler;

@end
