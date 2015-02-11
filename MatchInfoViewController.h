//
//  MatchInfoViewController.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/9/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchInfoViewController : UIViewController
@property (strong, nonatomic)UIViewController *parent;

+(MatchInfoViewController *)newWithMatch: (Match *) m;

@end
