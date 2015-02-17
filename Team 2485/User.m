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
    NSURL *tutorialsUrl = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/macros/s/AKfycbxOEOF_8_W_VoPbwzXcgOJusttV-3O6rw7qmFuC_mxOhCwxNM0/exec?firstName=%@&lastName=%@&loggingIn=%i&password=warlords2485valkyrie", self.first, self.last, [self isSignedIn] ? 0 : 1]];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    NSString *htmlData=[NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    NSString *shortenedData= [RankingsHandler searchString:htmlData
                                                      from:@"START"
                                                        to:@"END"];
    return shortenedData.intValue>0;
}
-(void)createUser {
    NSURL *tutorialsUrl = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/macros/s/AKfycbyzQseefINrXvBwWjsPOL2ecViDip107_ZJ9giYBGz9lP4nXa7Y/exec?firstName=%@&lastName=%@&grade=%i&password=warlords2485valkyrie", self.first, self.last, self.grade]];
    [NSData dataWithContentsOfURL:tutorialsUrl];
}
+(BOOL)isOnCampus: (CLLocation *)loc {
    double distanceDegsSq = pow(loc.coordinate.latitude-32.7701946, 2) + pow(loc.coordinate.longitude + 117.185371, 2);
    double maxFeet = 5000.0;
    return pow(maxFeet/6076.12/60, 2)>distanceDegsSq;
}
-(BOOL)isSignedIn {
    NSURL *tutorialsUrl = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/macros/s/AKfycbyCN0GSZt1WVMqQomxTIA8o8RrhVyIARpKXYErd5cD5pcXtCX_c/exec?first=%@&last=%@", self.first, self.last]];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    NSString *htmlData=[NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    NSString *shortenedData= [RankingsHandler searchString:htmlData
                                                      from:@"START"
                                                        to:@"END"];
    if (shortenedData.intValue<0) [self createUser];
    return shortenedData.intValue>0;
}
-(double)getHours{
    NSURL *tutorialsUrl = [NSURL URLWithString:[NSString stringWithFormat: @"https://script.google.com/macros/s/AKfycbzpP7Dq7nmSFbp2ZjVxejrmUAy7D0XUWZvsDQa1FgpNsxGixlI/exec?firstName=%@&lastName=%@", self.first, self.last]];
    NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
    NSString *htmlData=[NSString stringWithUTF8String:[tutorialsHtmlData bytes]];
    NSString *shortenedData= [RankingsHandler searchString:htmlData
                                                      from:@"START"
                                                        to:@"END"];
    return shortenedData.doubleValue;
}
-(void)save {
    NSArray *data = [NSArray arrayWithObjects:self.first, self.last, [NSNumber numberWithInt:self.grade], nil];
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir= [paths objectAtIndex:0];
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
    NSArray *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir= [paths objectAtIndex:0];
    if ([filemgr fileExistsAtPath:[docDir stringByAppendingPathComponent:@"userData"]]) {
        NSArray *data = [NSArray arrayWithContentsOfFile:[docDir stringByAppendingPathComponent:@"userData"]];
        User *u = [[User alloc] init];
        u.first = data[0];
        u.last = data[1];
        u.grade = ((NSNumber *)data[2]).intValue;
        return u;
    }
    return nil;
}
@end
