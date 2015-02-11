//
//  TwitterFeedHandler.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/5/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "TwitterFeedHandler.h"
@implementation TwitterFeedHandler
static NSMutableArray *matches;

+(NSArray *)downloadTweets {
    NSMutableArray * events = [NSMutableArray array];
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"Fy9MbbAXlrNvLzjwV2SHVbCWW"
                                                            consumerSecret:@"PLnRmNJc6PCGCqAvf464A7zkyY8HiQyrahzbqAiUHaQ54aSqT9"];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        NSLog(@"Access granted with %@", bearerToken);
        
        [twitter getUserTimelineWithScreenName:  [Constants twitterAccount] successBlock:^(NSArray *statuses) {
            for (NSString *str in statuses) {
                NSString *s2 = [NSString stringWithFormat:@"%@", str];
                NSRange r1 = [s2 rangeOfString:@"text = \""];
                NSString *temp = [s2 substringFromIndex:r1.location+r1.length];
                NSRange r2 = [temp rangeOfString: @"\";"];
                temp = [temp substringToIndex: r2.location];
                temp = [[[temp stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]
                        stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]
                        stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
                [events addObject:temp];
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"-- error: %@", error);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error %@", error);
    }];

    return events;
}
@end
