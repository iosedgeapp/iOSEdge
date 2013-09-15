//
//  BEPAppDelegate.m
//  BepBop
//
//  Created by Hiedi Utley on 9/1/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPAppDelegate.h"
#import "BEPMainViewController.h"
#import "BEPNavigationController.h"
#import "BEPAirDropHandler.h"
#import "BEPBackgroundDownloadHandler.h"

@interface BEPAppDelegate ()

@end

@implementation BEPAppDelegate

- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    if (IS_IOS_7) {
        [[BEPAirDropHandler sharedInstance] handleSavedAirDropURLs];
        [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    BEPMainViewController *mainViewController = [[BEPMainViewController alloc] initWithStyle:(IS_IOS_7 ? UITableViewStylePlain : UITableViewStyleGrouped)];

    BEPNavigationController* navigationController = [[BEPNavigationController alloc] initWithRootViewController:mainViewController];
    navigationController.navigationBar.translucent = IS_IOS_7;

    if ([navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    }
    
    self.window.rootViewController = navigationController;

    [self.window makeKeyAndVisible];
    return YES;
}


-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    void (^loggingCompletionHandler)(UIBackgroundFetchResult) = ^(UIBackgroundFetchResult result) {
        NSString* resultStr;
        switch (result) {
            case UIBackgroundFetchResultFailed: resultStr = @"failed"; break;
            case UIBackgroundFetchResultNoData: resultStr = @"no data"; break;
            case UIBackgroundFetchResultNewData: resultStr = @"new data"; break;
        }
        NSLog(@"Background fetch returning: %@", resultStr);
        completionHandler(result);
    };

    [[BEPBackgroundDownloadHandler sharedInstance] refreshWithCompletionHandler:^(BOOL didReceiveNewImage, NSError *error) {
        if (error) {
            loggingCompletionHandler(UIBackgroundFetchResultFailed);
        } else if (didReceiveNewImage) {
            [UIApplication sharedApplication].applicationIconBadgeNumber++;
            loggingCompletionHandler(UIBackgroundFetchResultNewData);
        } else {
            loggingCompletionHandler(UIBackgroundFetchResultNoData);
        }
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (sourceApplication == nil &&
        [[url absoluteString] rangeOfString:@"Documents/Inbox"].location != NSNotFound) // Incoming AirDrop
    {
        NSLog(@"%@ sent from %@ with annotation %@", url, sourceApplication, [annotation description]);
        if (application.protectedDataAvailable) {
            [[BEPAirDropHandler sharedInstance] moveToLocalDirectoryAirDropURL:url];
        }
        else {
            [[BEPAirDropHandler sharedInstance] saveAirDropURL:url];
        }
        return YES;
    }

    return NO;
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler
{
    /*
     Store the completion handler. The completion handler is invoked by the view controller's checkForAllDownloadsHavingCompleted method (if all the download tasks have been completed).
     */
	self.backgroundSessionCompletionHandler = completionHandler;
}

- (void) applicationWillResignActive:(UIApplication*)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void) applicationDidEnterBackground:(UIApplication*)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void) applicationWillEnterForeground:(UIApplication*)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void) applicationDidBecomeActive:(UIApplication*)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void) applicationWillTerminate:(UIApplication*)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
