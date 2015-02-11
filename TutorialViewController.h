//
//  TutorialViewController.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/3/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Tutorial.h"

@interface TutorialViewController : UIViewController<UIWebViewDelegate>

@property IBOutlet UITextView *label;
@property IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic)UIViewController *parent;
+(TutorialViewController *)newWithEvent: (Tutorial *) tut;
@end
