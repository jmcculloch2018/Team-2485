//
//  RegionalInfoViewController.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/9/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionalInfoViewController : UIViewController
@property (strong, nonatomic)UIViewController *parent;
-(void)initWithRegional: (Regional *)reggy;
@end
