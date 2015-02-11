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
+(RegionalInfoViewController *)newWithRegional:(Regional *)reggy {
    
    RegionalInfoViewController *rivc = [[RegionalInfoViewController alloc] init];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 65, rivc.view.frame.size.width, 50)];
    lab.text = reggy.name;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font  = [UIFont boldSystemFontOfSize:24];
    [rivc.view addSubview:lab];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0, 140, rivc.view.frame.size.width, 50)];
    lab2.text=[@"Location: " stringByAppendingString: reggy.location];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [UIFont boldSystemFontOfSize:24];
    [rivc.view addSubview:lab2];
    UILabel *lab3=[[UILabel alloc] initWithFrame:
                   CGRectMake(0, 225, rivc.view.frame.size.width, 50)];
    lab3.textAlignment=NSTextAlignmentCenter;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * dat = [NSDate dateWithTimeIntervalSince1970: reggy.startDate];
    NSString *temp = [formatter stringFromDate: dat];
    NSString *t = [ @"Start Date: " stringByAppendingString: temp];
    lab3.text = t;
    lab3.font  = [UIFont boldSystemFontOfSize:24];
    lab3.textColor = [Constants gold];
    [rivc.view addSubview:lab3];
    
    rivc.url = reggy.url;
    if (![rivc.url isEqualToString:@""]) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        but.frame = CGRectMake(0, 310, rivc.view.frame.size.width, 50);
        [but setTitle:@"Visit Website" forState:UIControlStateNormal];
        [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
        [but setFont:[UIFont boldSystemFontOfSize: 24]];
        [but addTarget:rivc
                action:@selector(web:)
      forControlEvents:UIControlEventTouchUpInside];
        [rivc.view addSubview:but];
    }
    rivc.view.backgroundColor=[UIColor blackColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(10, 15, 100, 50);
    [but setTitle:@"Close" forState:UIControlStateNormal];
    [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
    [but setFont:[UIFont systemFontOfSize:20]];
    [but addTarget:rivc
            action:@selector(back:)
  forControlEvents:UIControlEventTouchUpInside];
    [rivc.view addSubview:but];
    rivc.view.backgroundColor=[UIColor blackColor];
    
    return rivc;
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
