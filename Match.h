//
//  Match.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/6/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Constants.h"

@interface Match : NSObject
@property NSArray *winners, *losers;
@property NSDate *time;//√
@property NSString *identifier, *level;// quals, eights, quarters, semis, or finals √
@property int winPoints, losePoints, roundNum;
@property Regional *reg;//√
@property BOOL winOrLoss;//nil if looking at top matches
@end
