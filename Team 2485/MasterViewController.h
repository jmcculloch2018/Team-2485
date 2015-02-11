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
@class DetailViewController;

@interface MasterViewController : UITableViewController {
    Reachability *internetReachableFoo;
}

@property NSMutableArray *objects;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *events, *teams, *regs;
@property (strong, nonatomic) NSArray *tuts, *tweets;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;//Displays "twitter feed", or "Media"
@property BOOL hasInterwebs;
+(UILabel *)createLabelWithName: (NSString *) name big:(BOOL) big;

@end

