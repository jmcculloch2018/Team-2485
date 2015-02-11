//
//  UpcomingEventsHandler.h
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Constants.h"



@interface UpcomingEventsHandler : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

+(NSArray *)downloadEvents;

@end
