//
//  RegionalInfoViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/9/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "RegionalInfoViewController.h"

@interface RegionalInfoViewController ()
@property NSString *url;
@end

@implementation RegionalInfoViewController
-(void)initWithRegional: (Regional *)reggy {
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0*widthMultiplier(self), 40*heightMultiplier(self), 320*widthMultiplier(self), 100*heightMultiplier(self))];
    lab.text = reggy.name;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font  = [Constants title: widthMultiplier(self) * 24];
    [self.view addSubview:lab];
    lab.numberOfLines = 3;
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0*widthMultiplier(self), 115*heightMultiplier(self), 320*widthMultiplier(self), 100*heightMultiplier(self))];
    lab2.text=[@"Location: " stringByAppendingString: reggy.location];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [Constants body: widthMultiplier(self) * 24];
    lab2.numberOfLines = 3;
    [self.view addSubview:lab2];
    UILabel *lab3=[[UILabel alloc] initWithFrame:
                   CGRectMake(0*widthMultiplier(self), 225*heightMultiplier(self), 320*widthMultiplier(self), 50*heightMultiplier(self))];
    lab3.textAlignment=NSTextAlignmentCenter;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * dat = [NSDate dateWithTimeIntervalSince1970: reggy.startDate];
    NSString *temp = [formatter stringFromDate: dat];
    NSString *t = [ @"Start Date: " stringByAppendingString: temp];
    lab3.text = t;
    lab3.font  = [Constants body: widthMultiplier(self) * 24];
    lab3.textColor = [Constants gold];
    [self.view addSubview:lab3];
    
    self.url = reggy.url;
    if (![self.url isEqualToString:@""]) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        but.frame = CGRectMake(0*widthMultiplier(self), 310*heightMultiplier(self), 320*widthMultiplier(self), 50*heightMultiplier(self));
        [but setTitle:@"Visit Website" forState:UIControlStateNormal];
        [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
        [but setFont:[Constants body: widthMultiplier(self) *  24]];
        [but addTarget:self
                action:@selector(web:)
      forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:but];
    }
    self.view.backgroundColor=[UIColor blackColor];
    
}
-(IBAction)back:(id)sender {
    [self.parent dismissViewControllerAnimated:TRUE completion:nil];
}
-(IBAction)web:(id)sender {
    NSURL *url = [NSURL URLWithString:_url];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
