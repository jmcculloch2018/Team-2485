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
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0* widthMultiplier(self), heightMultiplier(self) * 80, 320* widthMultiplier(self), heightMultiplier(self) * 100)];
    lab.text = ev.name;
    lab.numberOfLines = 3;
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font = [Constants title: widthMultiplier(self) *24];
    [lab setFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y, lab.frame.size.width, [lab sizeThatFits:CGSizeMake(1, 1)].height)] ;
    [self.view addSubview:lab];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0* widthMultiplier(self), heightMultiplier(self) * 180, 320* widthMultiplier(self), heightMultiplier(self) * 100)];
    lab2.text=[@"When: " stringByAppendingString:[ev formattedDate]];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [Constants body: widthMultiplier(self) *24];
    [lab2 setFrame:CGRectMake(lab2.frame.origin.x, lab2.frame.origin.y, lab2.frame.size.width, [lab2 sizeThatFits:CGSizeMake(1, 1)].height)] ;

    [self.view addSubview:lab2];
    if (![[ev location] isEqualToString:@""]) {
        UILabel *lab3=[[UILabel alloc] initWithFrame:
                       CGRectMake(0* widthMultiplier(self), heightMultiplier(self) * 230, 320* widthMultiplier(self), heightMultiplier(self) * 200)];
        lab3.textAlignment=NSTextAlignmentCenter;
        lab3.text=[@"Where: " stringByAppendingString:[ev location]];
        lab3.font  = [Constants body: widthMultiplier(self) *24];
        lab3.textColor = [Constants gold];
        lab3.numberOfLines = 4;
        [lab3 setFrame:CGRectMake(lab.frame.origin.x, lab3.frame.origin.y, lab3.frame.size.width, [lab3 sizeThatFits:CGSizeMake(1, 1)].height)] ;
        [self.view addSubview:lab3];
    }

    self.view.backgroundColor=[Constants black];

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
