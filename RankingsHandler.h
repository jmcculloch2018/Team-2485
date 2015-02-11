//
//  RankingsHandler.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/7/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListOfMatches.h"
#import "Match.h"
@class Regional;
@interface RankingsHandler : NSObject
+(NSArray *)downloadTopTeams ;
+(Team *)findTeam: (int) teamNum;
+(NSArray *)downloadRegs;
+(NSArray *)downloadRegsForTeam : (Team *) team;
+(NSString *)convertToReadable: (Match *)m ;
+(NSString *)listAlliances: (Match *)m ;
+(ListOfMatches *) downloadMatchesForTeam: (Team *)theTeam regional: (Regional *) reg ;
@end
