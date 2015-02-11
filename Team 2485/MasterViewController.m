//
//  MasterViewController.m
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "MasterViewController.h"
@interface MasterViewController ()
@property BOOL hasTestedInterwebs;
@end

@implementation MasterViewController
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)
    [[self.splitViewController.viewControllers lastObject] topViewController];
    self.objects = [NSMutableArray arrayWithObjects: @"Twitter", @"Events", @"Media", @"Rankings", @"Tutorials", @"Resources", @"Team 2485 Sign-In", nil] ;
    
    
    self.navigationController.navigationBar.barTintColor = [Constants gold2];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.sectionIndexColor = [Constants gold];
    self.tableView.sectionIndexBackgroundColor = [Constants gold];
    self.tableView.sectionIndexTrackingBackgroundColor = [Constants gold];
    self.tableView.separatorColor = [UIColor blackColor];
    [self.navigationItem setTitleView:[MasterViewController createLabelWithName: @"Main Menu" big:YES]];
    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];

    if (URLString!=NULL) {
        NSLog(@"a");
        _tweets = [TwitterFeedHandler downloadTweets];
        NSLog(@"a");
        self.events = [UpcomingEventsHandler downloadEvents] ;
        NSLog(@"a");
        self.tuts = [[TutorialHandler downloadEvents] copy];
        NSLog(@"a");
        self.teams = [RankingsHandler downloadTopTeams];
        NSLog(@"a");
        self.regs = [RankingsHandler downloadRegs];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(UILabel *)createLabelWithName: (NSString *) name big:(BOOL) big{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.textColor = [UIColor blackColor];;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = [NSString stringWithString:name];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"BoomBox 2" size:big? 30:20];
    return titleLabel;
}
#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.parent=self;
        [controller setDetailItem:object];
        controller.navBar.title=[object description];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

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
        cell.textLabel.textColor = [UIColor blackColor];;
    } else {
        cell.backgroundColor = [UIColor blackColor];;
        cell.textLabel.textColor=[Constants gold];
    }
    cell.font = [UIFont fontWithName:@"Copperplate" size:24];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
