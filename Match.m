//
//  Match.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/6/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Match.h"

@implementation Match
-(NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@", [RankingsHandler convertToReadable:self], self.winOrLoss ? @"Win" : @"Loss"];
}
@end
