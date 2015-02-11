//
//  TeamInfoViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/9/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "TeamInfoViewController.h"

@interface TeamInfoViewController ()
@property NSString *url;
@end

@implementation TeamInfoViewController
+(TeamInfoViewController *)newWithTeam: (Team *)timmy {
    TeamInfoViewController *tivc = [[TeamInfoViewController alloc] init];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 65, tivc.view.frame.size.width, 50)];
    lab.text = [NSString stringWithFormat:@"Team %i : %@", timmy.number, timmy.name];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font  = [UIFont boldSystemFontOfSize:24];
    lab.numberOfLines = 3;
    [tivc.view addSubview:lab];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0, 140, tivc.view.frame.size.width, 50)];
    lab2.text=[@"Location: " stringByAppendingString: timmy.location];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [UIFont boldSystemFontOfSize:24];
    lab2.numberOfLines = 3;
    [tivc.view addSubview:lab2];
        UILabel *lab3=[[UILabel alloc] initWithFrame:
                       CGRectMake(0, 225, tivc.view.frame.size.width, 50)];
        lab3.textAlignment=NSTextAlignmentCenter;
        lab3.text=[NSString stringWithFormat: @"Rookie Year: %i", timmy.rookie];
        lab3.font  = [UIFont boldSystemFontOfSize:24];
        lab3.textColor = [Constants gold];
        [tivc.view addSubview:lab3];
    
    tivc.url = timmy.url;
    if (![tivc.url isEqualToString:@""]) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        but.frame = CGRectMake(0, 310, tivc.view.frame.size.width, 50);
        [but setTitle:@"Visit Website" forState:UIControlStateNormal];
        [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
        [but setFont:[UIFont boldSystemFontOfSize: 24]];
        [but addTarget:tivc
                action:@selector(web:)
      forControlEvents:UIControlEventTouchUpInside];
        [tivc.view addSubview:but];
    }
    tivc.view.backgroundColor=[UIColor blackColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(10, 15, 100, 50);
    [but setTitle:@"Close" forState:UIControlStateNormal];
    [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
    [but setFont:[UIFont systemFontOfSize:20]];
    [but addTarget:tivc
            action:@selector(back:)
  forControlEvents:UIControlEventTouchUpInside];
    [tivc.view addSubview:but];
    tivc.view.backgroundColor=[UIColor blackColor];
    
    return tivc;
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
