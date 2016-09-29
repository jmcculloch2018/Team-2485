//
//  User.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/11/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "User.h"

@implementation User
-(BOOL)toggleSign {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/a/macros/francisparker.org/s/AKfycbwQb77VaKMjJiEJKVaDx_irNfb9Iiq-gt-SsgrZ53eSZ01ax0M/exec?email=%@", self.email]];
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    NSString *htmlDataStr =[NSString stringWithUTF8String:[htmlData bytes]];
    return [htmlDataStr containsString:@"was signed"];
}

+(BOOL)isOnCampus: (CLLocation *)loc {
    double distanceDegsSq = pow(loc.coordinate.latitude-32.7701946, 2) + pow(loc.coordinate.longitude + 117.185371, 2);
    double maxFeet = 5000.0;
    return pow(maxFeet/6076.12/60, 2)>distanceDegsSq;
}
-(BOOL)isSignedIn {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/a/macros/francisparker.org/s/AKfycbz5Z6IfYnwT1m166fl-RmHg7k6-MJMpR-Zj0wXiLOxiTDl_oX4/exec?email=%@", self.email]];
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    NSString *htmlDataStr =[NSString stringWithUTF8String:[htmlData bytes]];
    return ![htmlDataStr containsString:@"not"];
}
-(double)getHours{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/a/macros/francisparker.org/s/AKfycbxFscf6rRpObr5k_joOEOiGK1jYCQ1Z4iWT5VmKNBIEeFzoaVST/exec?email=%@", self.email]];
    NSData *htmlData = [NSData dataWithContentsOfURL:url];
    NSString *htmlDataStr =[NSString stringWithUTF8String:[htmlData bytes]];
    NSString *shortenedData = [RankingsHandler searchString:htmlDataStr
                                                      from:@"You currently have "
                                                        to:@" hours"];
    return shortenedData.doubleValue;
}
-(void)save {
	NSArray *data = [NSArray arrayWithObjects:VERSION_STRING, self.email, nil];
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    [data writeToFile:[docDir stringByAppendingPathComponent:@"userData"] atomically:YES];
}
+(BOOL)deleteAccounts {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"userData"];
    return [fileManager removeItemAtPath:filePath error:nil];
}
+(User *)load {
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDir = [paths objectAtIndex:0];
	if ([filemgr fileExistsAtPath:[docDir stringByAppendingPathComponent:@"userData"]]) {
		NSArray *data = [NSArray arrayWithContentsOfFile:[docDir stringByAppendingPathComponent:@"userData"]];
		if ([data[0] isEqualToString:VERSION_STRING]) {
			User *u = [[User alloc] init];
			u.email = data[1];
			return u;
		}
	}
	return nil;
}
@end
