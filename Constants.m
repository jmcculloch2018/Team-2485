//
//  Constants.m
//  Team 2485
//
//  Created by Deidre MacKenna on 2/6/15.
//  Copyright (c) 2015 Jeremy McCulloch. All rights reserved.
//

#import "Constants.h"
@implementation Constants
+(UIColor *) gold {
    return [UIColor colorWithRed:227/255.0 green:191/255.0 blue:34/255.0 alpha:1.0];
}
+(UIColor *) black {
    return [UIColor colorWithRed:22/255.0 green:19/255.0 blue:3/255.0 alpha:1.0];
}
+(NSString *) password {
    return  @"warlords2485valkyrie";
}
+(UIColor *) systemBlue {
    return [[[[UIApplication sharedApplication] delegate] window] tintColor];
}
+(int) year {
    return 2016/*-1;//*/;
}
+(NSString *)twitterAccount {
    return @"FRCTeams";
}
+(NSString *)about {
    return @"We are Team 2485, the W.A.R. (We Are Robot) Lords, a FIRST robotics team! Our team is from Francis Parker School in San Diego, CA. As part of our FIRST involvement, we are dedicated to spreading our message throughout San Diego. We are always looking for opportunities to help out our community and hope to get even more involved in the coming years.";
}
+(UIFont *)body: (int) size  {
    return [UIFont fontWithName:@"Ubuntu" size:size];

}
+(UIFont *)title: (int) size {
    return [UIFont fontWithName:@"BoomBox 2" size:size];

}
+(int)mondayOfWeek1 {
    return 16489/*-360;//*/;
}
@end
