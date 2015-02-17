//
//  Event.m
//  Team 2485
//
//  Created by Deidre MacKenna on 1/23/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Event.h"

@implementation Event
-(NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", self.formattedDate, self.name];
}
@end
