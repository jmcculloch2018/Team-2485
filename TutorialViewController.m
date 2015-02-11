//
//  UpcomingEventsViewController.m
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "TutorialViewController.h"
@interface TutorialViewController ()

@end

@implementation TutorialViewController
+(TutorialViewController *)newWithEvent: (Tutorial *) tut {
    TutorialViewController *tvc = [[TutorialViewController alloc] init];
    NSString *videoURL = [tut url];
    UIWebView *videoView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, tvc.view.frame.size.width, tvc.view.frame.size.height)];
    videoView.backgroundColor = [UIColor clearColor];
    videoView.opaque = NO;
    videoView.delegate = tvc;
    [tvc.view addSubview:videoView];
    NSLog(@"%@", videoURL);
    
    NSString *videoHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <head>\
                           <style type=\"text/css\">\
                           iframe {position:absolute; top:50%%; margin-top:-130px;}\
                           body {background-color:#000; margin:0;}\
                           </style>\
                           </head>\
                           <body>\
                           <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                           </body>\
                           </html>", videoURL];
    
    [videoView loadHTMLString:videoHTML baseURL:nil];
    return tvc;
}
-(IBAction)back:(id)sender {
    [self.parent dismissViewControllerAnimated:TRUE completion:nil];
}
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
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
