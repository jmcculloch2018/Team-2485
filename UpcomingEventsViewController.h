//
//  UpcomingEventsViewController.h
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "UpcomingEventsViewController.h"
#import "Event.h"
@interface UpcomingEventsViewController : UIViewController {
    
}
@property IBOutlet UITextView *label;
@property IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic)UIViewController *parent;
+(UpcomingEventsViewController *)newWithEvent: (Event *) ev;
@end
