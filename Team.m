//
//  Team.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/6/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Team.h"

@implementation Team
-(NSString *)description {
    return [NSString stringWithFormat:@"Team %i - %@", self.number, self.name];
}
@end
