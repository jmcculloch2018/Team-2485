//
//  ScoutingFormViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "ScoutingFormViewController.h"

@interface ScoutingFormViewController ()

@end

@implementation ScoutingFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITextField *)makeTextField: (CGRect) f {
    UITextField *tf = [[UITextField alloc] initWithFrame: f];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.font = [UIFont systemFontOfSize:15];
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.keyboardType = UIKeyboardTypeDefault;
    tf.returnKeyType = UIReturnKeyNext;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.delegate = self;
    return tf;
}
-(UILabel *)makeLabelWithFrame: (CGRect) f text: (NSString *)t {
    UILabel *lab=[[UILabel alloc] initWithFrame: f];
    lab.font = [UIFont systemFontOfSize:18];
    lab.text = t;
    lab.textColor = [Constants gold];
    return lab;
}
-(ScoutingFormViewController *)init {
    self = [super init];
    //TODO: Method Stub
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
