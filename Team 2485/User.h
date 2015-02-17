//
//  User.h
//  Team 2485
//
//  Created by Deidre MacKenna on 2/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface User : NSObject
@property NSString *first, *last;
@property int grade;
-(BOOL)toggleSign;
-(void)createUser;
+(BOOL)isOnCampus: (CLLocation *)loc;
-(BOOL)isSignedIn;
-(void)save;
-(double)getHours;
+(User *)load;
+(BOOL)deleteAccounts;
@end
