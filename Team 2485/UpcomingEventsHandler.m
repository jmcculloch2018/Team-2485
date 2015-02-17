//
//  UpcomingEventsHandler.m
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "UpcomingEventsHandler.h"

@implementation UpcomingEventsHandler

+(NSArray *)downloadEvents {
    NSMutableArray * events = [NSMutableArray array]
    ;
    
    NSURL *tutorialsUrl = [NSURL URLWithString:@"https://script.google.com/macros/s/AKfycbyE_g6Q7rK_EfsU3yiH9KSBQHol1BJjSF1ZHjHbBkR-HxzITu4/exec"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    NSString *htmlData=[NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    
    NSRange r1=[htmlData rangeOfString:@"START"];
    NSRange r2=[htmlData rangeOfString:@"END"];
    NSString *shortenedData=[htmlData substringWithRange:NSMakeRange(r1.location+r1.length, r2.location-r1.location-r1.length)];
    
    NSArray *splitEvents=[shortenedData componentsSeparatedByString:@";"];
    
    for (NSString *eventStr in splitEvents) {
        
        NSArray *eventData = [eventStr componentsSeparatedByString:@"$"];
    
        if ([eventData count]>1) {
            Event *ev = [[Event alloc] init];
            
            ev.name = [eventData objectAtIndex:0];
            ev.formattedDate = [eventData objectAtIndex:1];
            ev.location=@"";
            if ([eventData count]>2)
                ev.location = [eventData objectAtIndex:2];
            
            [events addObject:ev];
        }
    }
    return [events copy];
}
@end
