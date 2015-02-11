//
//  TwitterFeedViewController.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/5/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Constants.h"

@interface TwitterFeedViewController : UIViewController

@property IBOutlet UITextView *label;
@property IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic)UIViewController *parent;
+(TwitterFeedViewController *)newWithDescription: (NSString *) description;
@end

