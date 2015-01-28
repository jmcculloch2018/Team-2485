//
//  DetailViewController.h
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpcomingEventsViewController.h"
@interface DetailViewController : UIViewController 

@property (strong, nonatomic) NSString *detailItem;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;//Displays "twitter feed", or "Media"
@property (strong, nonatomic) IBOutlet UIViewController *uevc;
@property (strong, nonatomic) UIViewController *parent;
@end
