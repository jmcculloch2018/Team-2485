//
//  MasterViewController.m
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//aaaaaaaa

#import "MasterViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MasterViewController ()
@end

@implementation MasterViewController
static double hMult, wMult;
-(IBAction)goBack:(UIStoryboardSegue *)segue {
    [self viewDidLoad];
}
+(BOOL)hasInterwebs {
    return TRUE;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    wMult = widthMultiplier(self); hMult = heightMultiplier(self);
    self.detailViewController = (DetailViewController *)
    [[self.splitViewController.viewControllers lastObject] topViewController];
    self.objects = [NSMutableArray arrayWithObjects: @"Twitter", @"Events",  @"Rankings", @"Tutorials", @"Resources", @"About Us", @"Team 2485 Sign In", nil] ;
    
    
    self.navigationController.navigationBar.barTintColor = [Constants gold];
    [self.navigationItem setTitleView:[MasterViewController createLabelWithName: @"Main Menu" big:NO]];
    
    self.tableView.backgroundColor = [Constants black];
    self.tableView.sectionIndexColor = [Constants gold];
    self.tableView.sectionIndexBackgroundColor = [Constants gold];
    self.tableView.sectionIndexTrackingBackgroundColor = [Constants gold];
    self.tableView.separatorColor = [Constants black];
    self.usr = [User load];

    if ([MasterViewController hasInterwebs]) {
        NSLog(@"a");
        _tweets = [TwitterFeedHandler downloadTweets];
        NSLog(@"a");
        self.events = [UpcomingEventsHandler downloadEvents] ;
        NSLog(@"a");
        self.tuts = [TutorialHandler downloadTuts];
        NSLog(@"a");
        self.teams = [RankingsHandler downloadTopTeams];
        NSLog(@"a");
        self.regs = [RankingsHandler downloadRegs];
        [self setup];
        if (self.usr != nil) {
            self.loggedIn = [self.usr isSignedIn];
            self.hours = [self.usr getHours];
        }
    }
    if ([[[UIDevice currentDevice] name] isEqualToString:@"iPad"]) [_detailViewController setDetailItem:@"Twitter"];
    
}
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // store all of the measurements, just so we can see what kind of data we might receive
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    //
    CLLocation *newLocation = manager.location;
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) {
        return;
    }
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    // test the measurement to see if it is more accurate than the previous measurement
    if (self.bestEffortAtLocation == nil || self.bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        _bestEffortAtLocation = newLocation;
        self.onCampus = [User isOnCampus:_bestEffortAtLocation];

        // store the location as the "best effort"
        // test the measurement to see if it meets the desired accuracy
        //
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            //
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            //

            [self stopUpdatingLocationWithMessage:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
            // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
        }
    }
    
    // update the display with the new location data
}
- (void)stopUpdatingLocationWithMessage:(NSString *)state {
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
}
- (void)setup {
    
    // Create the core location manager object
    _locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    self.locationManager.desiredAccuracy = 100.0;
    
    // Once configured, the location manager must be "started"
    //
    // for iOS 8, specific user level permission is required,
    // "when-in-use" authorization grants access to the user's location
    //
    // important: be sure to include NSLocationWhenInUseUsageDescription along with its
    // explanation string in your Info.plist or startUpdatingLocation will not work.
    //
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Turn off the location manager to save power.
    [self.locationManager stopUpdatingLocation];
}
+(UILabel *)createLabelWithName: (NSString *) name big:(BOOL) big{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0*wMult, 0*hMult, 320*wMult, 30*hMult)];
    titleLabel.textColor = [Constants black];;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithString:name];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [Constants  title: big ? 30:20];
    return titleLabel;
}
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *object = self.objects[indexPath.row];
    DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
    controller.parent=self;
    if (indexPath.row==self.objects.count-1 && self.usr==nil) [controller setDetailItem:@"Sign In"];
    else [controller setDetailItem:object];
    controller.navBar.title=[object description];
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;

}

#pragma mark - Table View
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *object = self.objects[indexPath.row];
    BOOL x =[MasterViewController hasInterwebs];
    BOOL displayThingy = FALSE;
    if (indexPath.row==self.objects.count-1 && self.usr==nil) {
        if (x) [self performSegueWithIdentifier:@"showDetail" sender:self];
        else displayThingy = TRUE;
    } else if ([object isEqualToString:@"Twitter"] && self.tweets.count==0 && !x)
        displayThingy = TRUE;
    else if ([object isEqualToString:@"Events"] && self.events.count==0 && !x)
        displayThingy = TRUE;
    else if ([object isEqualToString:@"Tutorials"] && self.tuts.count==0 && !x)
        displayThingy = TRUE;
    else {
        if ([object isEqualToString:@"Twitter"] && self.tweets.count==0)
            self.tweets = [TwitterFeedHandler downloadTweets];
        else if ([object isEqualToString:@"Events"] && self.events.count==0)
            self.events = [UpcomingEventsHandler downloadEvents];
        else if ([object isEqualToString:@"Tutorials"] && self.tuts.count==0)
            self.tuts = [TutorialHandler downloadTuts];
        [self performSegueWithIdentifier:@"showDetail" sender:self];
    }
    
    if (displayThingy) [MasterViewController noInternet:self]; 
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row%2==1) {
        cell.backgroundColor=[Constants gold];
        cell.textLabel.textColor = [Constants black];;
    } else {
        cell.backgroundColor = [Constants black];;
        cell.textLabel.textColor=[Constants gold];
    }
    cell.textLabel.font = [Constants body:24];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    return cell;
}
+(void)noInternet:(UIViewController *)s {//!!!!
    [[[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                message:@"Please connect to the internet"
                               delegate:s
                      cancelButtonTitle:@"OK"
                      otherButtonTitles: nil] show];
}
@end
