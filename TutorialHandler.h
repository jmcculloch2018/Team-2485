//
//  TutorialHandler.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/3/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Constants.h"

@interface TutorialHandler : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

+(NSArray *)downloadTuts;
@end
