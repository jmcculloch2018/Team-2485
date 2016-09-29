//
//  DetailViewController.h
//  Team 2485
//
//  Created by Jeremy McCulloch on 1/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Constants.h"
#import "Team.h"
@interface DetailViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate, UITextFieldDelegate>
@property (strong, nonatomic) UIViewController *parent;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;//Displays "twitter feed", or "Media"
@property (strong, nonatomic) IBOutlet UIViewController *uevc;
@property Team *theTeam;
@property IBOutlet UIViewController *master;
@property NSMutableArray *comps;
@property (strong, nonatomic) UITextField *emailField;
-(void)makeSignIn;
@end
