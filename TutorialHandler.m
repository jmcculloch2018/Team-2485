//
//  TutorialHandler.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/3/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "TutorialHandler.h"

@implementation TutorialHandler
+(NSArray *)downloadEvents {
    NSMutableArray * tuts = [NSMutableArray array]
    ;
    
    NSURL *tutorialsUrl = [NSURL URLWithString:@"https://script.google.com/macros/s/AKfycbxzAbLOM3wDowwa0rkZ-00WyAfXGvareBW3BEFl2GG2jPyfKnDa/exec"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    NSString *htmlData=[NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    NSRange r1=[htmlData rangeOfString:@"START"];
    NSRange r2=[htmlData rangeOfString:@"END"];
    NSString *shortenedData=[htmlData substringWithRange:NSMakeRange(r1.location+r1.length, r2.location-r1.location-r1.length)];
    NSArray *splitEvents=[shortenedData componentsSeparatedByString:@";"];
    for (NSString *eventStr in splitEvents) {
        
        NSArray *eventData = [eventStr componentsSeparatedByString:@", "];
        
        if ([eventData count]>1) {
            Tutorial *tut = [[Tutorial alloc] init];
            tut.name = [eventData objectAtIndex:0];
            tut.url = [eventData objectAtIndex:1];
            [tuts addObject:tut];
        }
    }
    return [tuts copy];
}
@end
