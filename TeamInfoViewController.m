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
-(void)initWithTeam: (Team *) timmy {
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 65*heightMultiplier(self), 320*widthMultiplier(self), 150*heightMultiplier(self))];
    lab.text = [NSString stringWithFormat:@"Team %i : %@", timmy.number, timmy.name];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font  = [Constants title: widthMultiplier(self) *  24];
    lab.numberOfLines = 3;
    [lab setFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y, lab.frame.size.width, [lab sizeThatFits:CGSizeMake(1, 1)].height)] ;
    [self.view addSubview:lab];
    
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0, 175*heightMultiplier(self), 320*widthMultiplier(self), 100*heightMultiplier(self))];
    lab2.text=[@"Location: " stringByAppendingString: timmy.location];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [Constants body: widthMultiplier(self) *  24];
    lab2.numberOfLines = 3;
    [lab2 setFrame:CGRectMake(lab2.frame.origin.x, lab2.frame.origin.y, lab2.frame.size.width, [lab2 sizeThatFits:CGSizeMake(1, 1)].height)] ;

    [self.view addSubview:lab2];
    
    UILabel *lab3=[[UILabel alloc] initWithFrame:
                   CGRectMake(0, 285*heightMultiplier(self), 320*widthMultiplier(self), 50*heightMultiplier(self))];
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.text=[NSString stringWithFormat: @"Rookie Year: %i", timmy.rookie];
    lab3.font  = [Constants body: widthMultiplier(self) *  24];
    lab3.textColor = [Constants gold];
    [self.view addSubview:lab3];
    
    self.url = timmy.url;
    if (![self.url isEqualToString:@""]) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        but.frame = CGRectMake(0, 395*heightMultiplier(self), 320*widthMultiplier(self), 50*heightMultiplier(self));
        [but setTitle:@"Visit Website" forState:UIControlStateNormal];
        [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
        [but setFont:[Constants body: widthMultiplier(self) *  24]];
        [but addTarget:self
                action:@selector(web:)
      forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:but];
    }
    self.view.backgroundColor=[Constants black];
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
