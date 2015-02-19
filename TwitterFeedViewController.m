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
-(void)initWithDescription: (NSString *) description {
    UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0*widthMultiplier(self), heightMultiplier(self) * 65, 320*widthMultiplier(self), heightMultiplier(self) * 370)];
    lab.font= [Constants body: widthMultiplier(self) * 25];
    lab.textColor = [Constants gold];
    lab.text=description;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 10;
    [self.view addSubview:lab];
    @try {
        self.url = [TwitterFeedHandler getUrlFromString:description];
        UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        but.frame = CGRectMake(130*widthMultiplier(self), heightMultiplier(self) * 400, 100*widthMultiplier(self), heightMultiplier(self) * 50);;
        [but setTitle:@"Visit URL" forState:UIControlStateNormal];
        [but setTitleColor:[Constants gold] forState:UIControlStateNormal];
        [but setFont:[Constants body: widthMultiplier(self) * 20]];
        [but addTarget:self
                action:@selector(openWebpage:)
      forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:but];
    } @catch (NSException *exception) {
        
    }
    self.view.backgroundColor=[Constants black];
}
-(IBAction)openWebpage:(id)sender {
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
