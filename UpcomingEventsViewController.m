//
//  UpcomingEventsViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "UpcomingEventsViewController.h"
@interface UpcomingEventsViewController ()

@end

@implementation UpcomingEventsViewController
-(void)initWithEvent: (Event *) ev {
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0* widthMultiplier(self), heightMultiplier(self) * 65, 320* widthMultiplier(self), heightMultiplier(self) * 50)];
    lab.text = ev.name;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font = [Constants title: widthMultiplier(self) *24];
    [self.view addSubview:lab];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0* widthMultiplier(self), heightMultiplier(self) * 140, 320* widthMultiplier(self), heightMultiplier(self) * 50)];
    lab2.text=[@"When: " stringByAppendingString:[ev formattedDate]];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [Constants body: widthMultiplier(self) *24];
    [self.view addSubview:lab2];
    if (![[ev location] isEqualToString:@""]) {
        UILabel *lab3=[[UILabel alloc] initWithFrame:
                       CGRectMake(0* widthMultiplier(self), heightMultiplier(self) * 225, 320* widthMultiplier(self), heightMultiplier(self) * 150)];
        lab3.textAlignment=NSTextAlignmentCenter;
        lab3.text=[@"Where: " stringByAppendingString:[ev location]];
        lab3.font  = [Constants body: widthMultiplier(self) *24];
        lab3.textColor = [Constants gold];
        lab3.numberOfLines = 4;
        [lab3 sizeToFit];
        [self.view addSubview:lab3];
    }

    self.view.backgroundColor=[UIColor blackColor];

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
