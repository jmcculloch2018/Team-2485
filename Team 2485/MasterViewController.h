//
//  MasterViewController.h
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *events;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;//Displays "twitter feed", or "Media"
+(UILabel *)createLabelWithName: (NSString *) name big:(BOOL) big;

@end

