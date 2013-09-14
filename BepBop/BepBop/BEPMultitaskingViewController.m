//
//  BEPMultitaskingViewController.m
//  BepBop
//
//  Created by Cody A. Ray on 9/14/13.
//  Copyright (c) 2013 Bleeding Edge Press. All rights reserved.
//

#import "BEPMultitaskingViewController.h"

#define BLog(formatString, ...) NSLog((@"%s " formatString), __PRETTY_FUNCTION__, ##__VA_ARGS__);

static NSString *DownloadURLString = @"http://localhost/bigImage.png";

@interface BEPMultitaskingViewController ()

@property (nonatomic) NSMutableArray *images;
@property (nonatomic) NSMutableArray *progressViews;
@property (nonatomic) NSMutableArray *downloadTasks;
@property (nonatomic) NSDateFormatter *formatter;
@property (nonatomic) NSURLSession *session;

@end

@implementation BEPMultitaskingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.images = [NSMutableArray array];
        self.progressViews = [NSMutableArray array];
        self.downloadTasks = [NSMutableArray array];
        self.formatter = [[NSDateFormatter alloc] init];
        [self.formatter setDateFormat:@"MMM d, h:mm:ss a"];
        [self setupRefreshControl];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self setupFooter];
    }
    return self;
}

// this is just t hide the empty rows ~ http://stackoverflow.com/a/6738534/337735
- (void)setupFooter
{
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    emptyView.backgroundColor = [UIColor whiteColor];
    [self.tableView setTableFooterView:emptyView];
}

#pragma mark - Refresh Control

- (void)setupRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
}

- (void)refreshControlRequest
{
    [self performSelector:@selector(performBackgroundTransfer)];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [self.formatter stringFromDate:[NSDate date]]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.session = [self backgroundSession];
    self.title = NSLocalizedString(@"Chapter 4", nil);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.images.count; // same as [self.progressViews count] and [self.downloadTasks count]
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    UIImage *image = [self.images objectAtIndex:indexPath.row];
    if (image != (id)[NSNull null]) {
        cell.imageView.image = image;
        cell.imageView.contentMode = UIViewContentModeScaleToFill;//UIViewContentModeScaleAspectFill;//UIViewContentModeScaleAspectFit;
        cell.textLabel.text = [self.formatter stringFromDate:[NSDate date]];
    } else {
        cell.textLabel.text = @"Loading...";
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.images removeObjectAtIndex:indexPath.row];
        [self.progressViews removeObjectAtIndex:indexPath.row];
        [self.downloadTasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self performBackgroundTransfer];
    }
}

#pragma mark - Background Transfer

- (BOOL)performBackgroundTransfer
{
    BLog();
    NSURL *downloadURL = [NSURL URLWithString:DownloadURLString];
	NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
	NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request];
    [downloadTask resume];

        BLog(@"#BRows: %d %d %d", [self.images count], [self.progressViews count], [self.downloadTasks count]);
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:DownloadURLString]]];
        [self.images insertObject:[NSNull null] atIndex:0];
        [self.progressViews insertObject:[NSNull null] atIndex:0];
        [self.downloadTasks insertObject:downloadTask atIndex:0];
        BLog(@"#ARows: %d %d %d", [self.images count], [self.progressViews count], [self.downloadTasks count]);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    return YES;
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


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    BLog();

    /*
     Report progress on the task.
     If you created more than one task, you might keep references to them and report on them individually.
     */

//    if (downloadTask == self.downloadTask)
//    {
//        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
//        BLog(@"DownloadTask: %@ progress: %lf", downloadTask, progress);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.progressView.progress = progress;
//        });
//    }
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
            UIImage *image = [UIImage imageWithContentsOfFile:[destinationURL path]];
            for (int i = 0; i < [self.downloadTasks count]; i++) {
                if ([self.downloadTasks objectAtIndex:i] == downloadTask) {
                    [self.images replaceObjectAtIndex:i withObject:image];
                    // now reload this row with the image
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }
            }
        });
    }
    else
    {
        /*
         In the general case, what you might do in the event of failure depends on the error and the specifics of your application.
         */
        BLog(@"Error during the copy: %@", [errorCopy localizedDescription]);
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

//    self.downloadTask = nil;
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
