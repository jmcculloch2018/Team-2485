//
//  MasterViewController.h
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "User.h"
@class DetailViewController;

@interface MasterViewController : UITableViewController<CLLocationManagerDelegate> {
    Reachability *internetReachableFoo;
}
@property BOOL loggedIn, onCampus;
@property NSMutableArray *objects;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *events, *teams, *regs;
@property (strong, nonatomic) NSArray *tuts, *tweets;
@property User *usr;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;//Displays "twitter feed", or "Media"
@property CLLocationManager *locationManager;
@property CLLocation *bestEffortAtLocation;
@property double hours;
- (void)setup;
+(UILabel *)createLabelWithName: (NSString *) name big:(BOOL) big;
+(BOOL)hasInterwebs;
+(void)noInternet: (UIViewController *)s;
-(IBAction)goBack:(UIStoryboardSegue *)segue;

@end

