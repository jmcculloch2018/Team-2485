//
//  RankingsHandler.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/7/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "RankingsHandler.h"
#import "Regional.h"

@implementation RankingsHandler
+(Team *)findTeam: (int) teamNum {
    @try {
        Team *team = [[Team alloc] init];
        team.number = teamNum;
        
        NSURL *tutorialsUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.thebluealliance.com/api/v2/team/frc%i?X-TBA-App-Id=frc2485:app:v01", teamNum]];
        NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
        NSString *htmlData = [NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
        
        team.name = [RankingsHandler searchString:htmlData from: @"\"nickname\": \"" to: @"\"}"];
        team.location = [RankingsHandler searchString:htmlData from: @"\"location\": \"" to: @"\", \"key\""];
        team.rookie = [RankingsHandler searchString:htmlData from: @"\"rookie_year\": " to: @", \"region\""].intValue;
        @try {
            team.url = [RankingsHandler searchString:htmlData from: @"\"website\": \"" to: @"\", \"name\""];
        }
        @catch (NSException *exception) {
            team.url = @"";
        }
        
        return team;
    } @catch(NSException *e) {
        Team *team = [[Team alloc] init];
        team.number = -1;
        return team;
    }
}
+(NSString *)searchString: (NSString *)str from: (NSString *)start to: (NSString *) end {
    NSRange r1 = [str rangeOfString: start];
    NSRange r2 = [str rangeOfString: end];
    return [str substringWithRange: NSMakeRange(r1.location+r1.length, r2.location-r1.location-r1.length)];
}
+(NSArray *)regsFromString: (NSString *) url  {
    NSMutableArray * events = [NSMutableArray array];
    
    NSURL *tutorialsUrl = [NSURL URLWithString:url];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    NSString *htmlData = [NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    NSString *shortenedData = [htmlData substringWithRange:NSMakeRange(2, [htmlData length]-4)];
    
    NSArray *splitData = [shortenedData componentsSeparatedByString:@"}, {\"key\""];//to differentiate from just
    for (NSString *str in splitData) {
         Regional *reg = [[Regional alloc] init];
        
         NSString *startStr = [RankingsHandler searchString:str from: @"\"start_date\": \"" to: @"\", \"event_type\""];
         NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
         [formatter setDateFormat:@"yyyy-MM-dd"];
         
         reg.startDate = [formatter dateFromString:startStr].timeIntervalSince1970;
         reg.identifier = [RankingsHandler searchString:str from: @": \"" to: @"\", \"website\""];
        @try {
            reg.name = [RankingsHandler searchString:str from:@"\"short_name\": \"" to:@"\", \"facebook_eid\""];;
        }
        @catch (NSException *exception) {
            reg.name = [RankingsHandler searchString:str from:@"\"name\": \"" to:@"\", \"short_name\""];;
        }
        
         reg.location = [RankingsHandler searchString:str from:@"\"location\": \"" to:@"\", \"event_code\""];;
         
         @try {
             reg.url = [RankingsHandler searchString:str from: @"\"website\": \"" to:@"\", \"official\""];
         } @catch (NSException *exception) {
             reg.url = @"";
         }
        [events addObject:reg];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    return [events sortedArrayUsingDescriptors:sortDescriptors];
}
+(NSArray *)downloadRegsForTeam : (Team *) team {
    return [[RankingsHandler regsFromString:[NSString stringWithFormat:@"http://www.thebluealliance.com/api/v2/team/frc%i/%i/events?X-TBA-App-Id=frc2485:app:v01", team.number, [Constants year]]] arrayByAddingObject:@"More Info"];
}
+(ListOfMatches *) downloadMatchesForTeam: (Team *)theTeam regional: (Regional *) reg {
    ListOfMatches *ret = [[ListOfMatches alloc] init];
    
    ret.team = theTeam;
    ret.reg = reg;
    ret.matches = [NSMutableArray array];
    
    NSURL *tutorialsUrl = [NSURL URLWithString:
                           [NSString stringWithFormat:
                            @"http://www.thebluealliance.com/api/v2/team/frc%i/event/%@/matches?X-TBA-App-Id=frc2485:app:v01", ret.team.number, ret.reg.identifier ]];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    NSString *htmlData = [NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    
    if ([htmlData length]>4) {
        NSString *shortenedData = [htmlData substringWithRange:NSMakeRange(2, [htmlData length]-4)];
        NSArray *splitData = [shortenedData componentsSeparatedByString:@"}, {\"comp_level\""];
        for (NSString *rank in splitData) {
            Match *m = [[Match alloc] init];
            
            m.level = [RankingsHandler searchString:rank from:@": \"" to:@"\", \"match_number\""];
            m.roundNum = [RankingsHandler searchString:rank from:@"\"match_number\": " to: @", \"videos\""].intValue;
            m.identifier = [RankingsHandler searchString:rank from:@"\"key\": \"" to:@"\", \"time\""];
            m.reg = ret.reg;
            
            NSString *longStr = [RankingsHandler searchString:rank
                            from: @"\"alliances\": {\"blue\": {"
                            to:@"}}, \"event_key\""];
            NSArray *shorterStrings = [longStr componentsSeparatedByString:
                                       @"}, \"red\": {"];
            NSString *blue = [shorterStrings objectAtIndex:0];
            NSString *red = [shorterStrings objectAtIndex:1];
            
            NSString *bs = [RankingsHandler searchString:blue
                                            from: @"\"score\": "
                                                to:@", \"teams\": [\"frc"];
            NSString *bAll = [RankingsHandler searchString:blue from: @", \"teams\": [\"frc" to:@"\"]"];
            
            NSString *rs = [RankingsHandler searchString:red from: @"\"score\": " to:@", \"teams\": [\"frc"];
            NSString *rAll = [RankingsHandler searchString:red from:
                              @", \"teams\": [\"frc" to:@"\"]"];
            
            if (rs.intValue>bs.intValue) {
                m.winPoints = rs.intValue;
                m.losePoints = bs.intValue;
                m.winners = [rAll componentsSeparatedByString:@"\", \"frc"];
                m.losers = [bAll componentsSeparatedByString:@"\", \"frc"];
            } else{
                m.losePoints = rs.intValue;
                m.winPoints = bs.intValue;
                m.losers = [rAll componentsSeparatedByString:@"\", \"frc"];
                m.winners = [bAll componentsSeparatedByString:@"\", \"frc"];
            }
            
            m.winOrLoss = NO;
            for (NSString *str in m.winners)
                if (str.intValue == ret.team.number)
                    m.winOrLoss = YES;
            
            [ret.matches addObject:m];
        }
    } else [ret.matches addObject:@"No matches are avaliable for the given selection" ];
    
    return ret;
}
+(NSArray *)downloadRegs {
    return [RankingsHandler regsFromString:
            [NSString stringWithFormat:@"http://www.thebluealliance.com/api/v2/events/%i?X-TBA-App-Id=frc2485:app:v01", [Constants year]]];
}
+(NSArray *)downloadTopTeams {
    NSMutableArray * teams = [NSMutableArray array]
    ;
    
    NSURL *tutorialsUrl = [NSURL URLWithString:@"https://script.google.com/macros/s/AKfycbw4hD1e9-j-HyeYBNdAJYR0Cm7BddgiXnjpvy_l3LlkjXWMVY4/exec"];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    
    NSString *htmlData=[NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    NSString *shortenedData= [RankingsHandler searchString:htmlData
                                                      from:@"START"
                                                        to:@"END"];
    NSArray *splitEvents=[shortenedData componentsSeparatedByString:@";"];
    
    for (NSString *eventStr in splitEvents) {
        NSArray *eventData = [eventStr componentsSeparatedByString:@","];
        
        if ([eventData count]>2) {
            Team *t = [[Team alloc] init];
            
            t.number = ((NSString*) eventData[0]).intValue;
            t.name = eventData[1];
            t.rookie = ((NSString*) eventData[2]).intValue;
            t.url = eventData[2];
            
            [teams addObject:t];
            
        } else if (![eventData[0] isEqualToString:@""])
            [teams addObject:eventData[0]];
        
    }
    return [teams copy];
}
+(NSString *)convertToReadable: (Match *)m {
    return [NSString stringWithFormat:@"%@ #%i",
            [m.level isEqualToString:@"qm"] ? @"Qualifier" :
            [m.level isEqualToString:@"ef"] ? @"Eighth Final" :
            [m.level isEqualToString:@"qf"] ? @"Quarter Final" :
            [m.level isEqualToString:@"sf"] ? @"Semifinal" : @"Final",
            m.roundNum];
}
+(NSString *)listAlliances: (Match *)m {
    return [NSString stringWithFormat: @"Teams %@, %@, and %@ vs %@, %@, and %@",
            m.winners[0], m.winners[1], m.winners[2],
            m.losers[0], m.losers[1], m.losers[2]];
}
@end
