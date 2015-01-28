//
//  UpcomingEventsViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "UpcomingEventsViewController.h"
#import "Event.h"
@interface UpcomingEventsViewController ()

@end

@implementation UpcomingEventsViewController
+(UpcomingEventsViewController *)newWithEvent: (Event *) ev {
    UpcomingEventsViewController *uevc = [[UpcomingEventsViewController alloc] init];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 25, uevc.view.frame.size.width, 50)];
    lab.font=[UIFont fontWithName:@"Helvetica" size:20];
    lab.text=[ev name];
    lab.textAlignment=NSTextAlignmentCenter;
    [uevc.view addSubview:lab];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0, 125, uevc.view.frame.size.width, 50)];
    lab2.text=[@"When: " stringByAppendingString:[ev formattedDate]];
    lab2.textAlignment=NSTextAlignmentCenter;

    [uevc.view addSubview:lab2];
    if (![[ev location] isEqualToString:@""]) {
        UILabel *lab3=[[UILabel alloc] initWithFrame:
                       CGRectMake(0, 225, uevc.view.frame.size.width, 50)];
        lab3.textAlignment=NSTextAlignmentCenter;
        lab3.text=[@"Where: " stringByAppendingString:[ev location]];
        [uevc.view addSubview:lab3];
    }
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(uevc.view.frame.size.width/2, 400, 100, 50);
    [but setTitle:@"Close" forState:UIControlStateNormal];
    [but addTarget:uevc
            action:@selector(back:)
  forControlEvents:UIControlEventTouchUpInside];
    [uevc.view addSubview:but];
    uevc.view.backgroundColor=[UIColor whiteColor];
    return uevc;
}
-(IBAction)back:(id)sender {
    [self.parent dismissViewControllerAnimated:TRUE completion:nil];
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
