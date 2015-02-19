//
//  Regional.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/6/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Regional.h"

@implementation Regional
-(NSString *)description {
    return self.name;
}
-(int)getWeek {
    int time  = self.startDate/86400 - [Constants mondayOfWeek1];//days since start of competition season
    return time/7 + 1;
}
@end
