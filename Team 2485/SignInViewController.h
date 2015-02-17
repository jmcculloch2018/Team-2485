//
//  SignInViewController.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) UITextField *tf, *tf2, *tf3, *tf4;
@property UIViewController *parent;
-(void)initWithParent:(UIViewController *)par ;
@end
