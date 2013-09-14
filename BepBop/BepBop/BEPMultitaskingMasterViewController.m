//
//  BEPMultitaskingMasterViewController.m
//  BepBop
//
//  Created by Cody A. Ray on 9/13/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMultitaskingMasterViewController.h"
#import "BEPMultitaskingDetailViewController.h"
#import "BEPMultitaskingListItem.h"

//TODO: To run this sample correctly, you must set an appropriate URL here.
static NSString *DownloadURLString = @"http://lorempixel.com/400/200/animals/%d/";

@interface BEPMultitaskingMasterViewController ()
@property (nonatomic) NSMutableArray *objects; // ListItem - same index as tableView
@property (nonatomic) NSMutableDictionary *dict; // NSString => ListItem

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;
@end

@implementation BEPMultitaskingMasterViewController
- (IBAction)start:(id)sender {
    [self insertNewObject];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - background fetch

- (void)performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"GOT BG FETCH");
    [self startNewBackgroundFetch];
    [UIApplication sharedApplication].applicationIconBadgeNumber++;

    /*
     At the end of the fetch, invoke the completion handler.
     */
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)startNewBackgroundFetch
{
    NSLog(@"insertNewObject");
    u_int32_t r = arc4random_uniform(10);
    NSString* key = [NSString stringWithFormat:@"%d", r];

    NSURL *downloadURL = [NSURL URLWithString:[NSString stringWithFormat:DownloadURLString, r]];
	self.downloadTask = [self.session downloadTaskWithURL:downloadURL];
    self.downloadTask.taskDescription = key;

    BEPMultitaskingListItem *item = [[BEPMultitaskingListItem alloc] init];
    item.date = [NSDate date];

    [self.dict setObject:item forKey:key];
    [self.objects insertObject:item atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    [self.downloadTask resume];
}

-(NSMutableArray *)objects
{
    if (_objects == nil) {
        _objects = [[NSMutableArray alloc] init];
    }
    return _objects;
}

-(NSMutableDictionary *)dict
{
    if (_dict == nil) {
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}

#pragma mark - view controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Chapter 4";

    self.session = [self backgroundSession];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        NSString *dateFormatString = [NSDateFormatter dateFormatFromTemplate:@"MMM d, hh:mm:ss a" options:0 locale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormatString];
    }

    // Configure the cell...
    NSDate *date = ((BEPMultitaskingListItem *)self.objects[indexPath.row]).date;
    cell.textLabel.text = [dateFormatter stringFromDate:date];

    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [self insertNewObject];
    }
}

- (NSURLSession *)backgroundSession
{
    /*
     Using disptach_once here ensures that multiple background sessions with the same identifier are not created in this instance of the application. If you want to support multiple background sessions within a single process, you should create each session with its own identifier.
     */
	static NSURLSession *session = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"com.example.apple-samplecode.SimpleBackgroundTransfer.BackgroundSession"];
		session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
	});
	return session;
}

#pragma mark - Table view delegate

#define BLog(formatString, ...) NSLog((@"%s " formatString), __PRETTY_FUNCTION__, ##__VA_ARGS__);

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
     BEPMultitaskingDetailViewController *detailViewController = [[BEPMultitaskingDetailViewController alloc] initWithNibName:nil bundle:nil];

    // Pass the selected object to the new view controller.
    detailViewController.detailItem = self.objects[indexPath.row];
    detailViewController.masterController = self;

    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Background transfer

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    BLog();

    if (downloadTask == self.downloadTask)
    {
        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        NSLog(@"DownloadTask: %@ progress: %lf", downloadTask, progress);
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.progressView.progress = progress;
        });
    }
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL
{
    BLog();

    /*
     The download completed, you need to copy the file at targetPath before the end of this block.
     As an example, copy the file to the Documents directory of your app.
     */
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = [URLs objectAtIndex:0];

    NSURL *originalURL = [[downloadTask originalRequest] URL];
    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:[originalURL lastPathComponent]];
    NSError *errorCopy;

    // For the purposes of testing, remove any esisting file at the destination.
    [fileManager removeItemAtURL:destinationURL error:NULL];
    BOOL success = [fileManager copyItemAtURL:downloadURL toURL:destinationURL error:&errorCopy];

    if (success)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            BEPMultitaskingListItem* item = [self.dict objectForKey:downloadTask.taskDescription];
            item.path = [destinationURL path];

//            UIImage *image = [UIImage imageWithContentsOfFile:[destinationURL path]];
//            self.imageView.image = image;
//            self.imageView.hidden = NO;
//            self.progressView.hidden = YES;
        });
    }
    else
    {
        /*
         In the general case, what you might do in the event of failure depends on the error and the specifics of your application.
         */
//        BLog(@"Error during the copy: %@", [errorCopy localizedDescription]);
    }
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    BLog();

    if (error == nil)
    {
        NSLog(@"Task: %@ completed successfully", task);
    }
    else
    {
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }

//    double progress = (double)task.countOfBytesReceived / (double)task.countOfBytesExpectedToReceive;
//	dispatch_async(dispatch_get_main_queue(), ^{
//		self.progressView.progress = progress;
//	});

    self.downloadTask = nil;
}


/*
 If an application has received an -application:handleEventsForBackgroundURLSession:completionHandler: message, the session delegate will receive this message to indicate that all messages previously enqueued for this session have been delivered. At this time it is safe to invoke the previously stored completion handler, or to begin any internal updates that will result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    BEPAppDelegate *appDelegate = (BEPAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundSessionCompletionHandler) {
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
    }

    NSLog(@"All tasks are finished");
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    BLog();
}


@end
