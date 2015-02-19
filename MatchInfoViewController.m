//
//  MatchInfoViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/9/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "MatchInfoViewController.h"

@interface MatchInfoViewController ()
@property NSString *url;
@end

@implementation MatchInfoViewController
-(void)initWithMatch: (Match *)mDawg {
    
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0*widthMultiplier(self), heightMultiplier(self)* 80, 320*widthMultiplier(self), heightMultiplier(self)* 100)];
    lab.text = [RankingsHandler convertToReadable:mDawg];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.numberOfLines = 2;
    lab.font  = [Constants title: widthMultiplier(self) * 24];
    [lab setFrame:CGRectMake(lab.frame.origin.x, lab.frame.origin.y, lab.frame.size.width, [lab sizeThatFits:CGSizeMake(1, 1)].height)] ;

    [self.view addSubview:lab];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(0*widthMultiplier(self), heightMultiplier(self)* 180, 320*widthMultiplier(self), heightMultiplier(self)* 100)];
    lab2.text= [RankingsHandler listAlliances: mDawg];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab.textColor = [Constants gold];lab2.textColor = [Constants gold];
    lab2.font  = [Constants body: widthMultiplier(self) * 24];
    lab2.numberOfLines = 3;
    [lab2 setFrame:CGRectMake(lab2.frame.origin.x, lab2.frame.origin.y, lab2.frame.size.width, [lab2 sizeThatFits:CGSizeMake(1, 1)].height)] ;
    [self.view addSubview:lab2];
    
    UILabel *lab3=[[UILabel alloc] initWithFrame:
                   CGRectMake(0*widthMultiplier(self), heightMultiplier(self)* 280, 320*widthMultiplier(self), heightMultiplier(self)* 100)];
    lab3.textAlignment=NSTextAlignmentCenter;
    
    lab3.text = [NSString stringWithFormat:@"Final Score: %i to %i",
                 mDawg.winPoints, mDawg.losePoints];
    lab3.font  = [Constants body: widthMultiplier(self) * 24];
    lab3.textColor = [Constants gold];
    [lab3 setFrame:CGRectMake(lab3.frame.origin.x, lab3.frame.origin.y, lab3.frame.size.width, [lab3 sizeThatFits:CGSizeMake(1, 1)].height)] ;

    [self.view addSubview:lab3];
    
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
