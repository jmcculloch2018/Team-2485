//
//  TwitterFeedViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/5/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "TwitterFeedViewController.h"
@interface TwitterFeedViewController ()

@end

@implementation TwitterFeedViewController
+(TwitterFeedViewController *)newWithDescription: (NSString *) description {
    TwitterFeedViewController *tfvc = [[TwitterFeedViewController alloc] init];
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, 65, tfvc.view.frame.size.width, tfvc.view.frame.size.height-110)];
    lab.font=[UIFont fontWithName:@"Helvetica" size:25];
    lab.textColor = [Constants gold];
    lab.text=description;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 10;
    lab.font = [UIFont boldSystemFontOfSize: 24];
    [tfvc.view addSubview:lab];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(10, 15, 100, 50);;
    [but setTitle:@"Close" forState:UIControlStateNormal];
    [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
    [but setFont:[UIFont systemFontOfSize:20]];
    [but addTarget:tfvc
            action:@selector(back:)
  forControlEvents:UIControlEventTouchUpInside];
    [tfvc.view addSubview:but];
    tfvc.view.backgroundColor=[UIColor blackColor];
    return tfvc;
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
