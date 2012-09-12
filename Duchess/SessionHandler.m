//
//  SessionHandler.m
//  Durham Life
//
//  Created by Matthew Bates on 27/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "SessionHandler.h"

static NSString* const USER_KEY = @"user";
static NSString* const FIRST_USE_KEY = @"first_use";

@implementation SessionHandler

+ (DUUser*)getUser
{
    NSData* userData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_KEY];
    DUUser* user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return user;
}

+ (void)saveUser:(DUUser*)user
{
    NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER_KEY];
}

+ (void)setDefaults
{
    DUUser* user = [DUUser new];
    user.userAffiliation = VISITOR;
    user.colleges = [NSMutableSet new];
    user.categoryPreferences = [NSMutableSet setWithObjects:
                                @"University",
                                @"College",
                                @"Music",
                                @"Theatre",
                                @"Exhibitions",
                                @"Sport",
                                @"Conferences",
                                @"Community",
                                nil];
    user.subscribedSocities = [NSMutableArray new];
    user.bookmarkedEvents = [NSMutableDictionary new];
    
    NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:
     [NSDictionary dictionaryWithObjectsAndKeys:
      userData, USER_KEY,
      [NSNumber numberWithBool:YES], FIRST_USE_KEY,
      nil]];
    NSLog(@"Setting Default User Settings");
}

+ (BOOL)appOpenedForFirstTime
{
    BOOL ans = [[NSUserDefaults standardUserDefaults] boolForKey:FIRST_USE_KEY];
    return ans;
}

+ (void)setAppOpenedForFirstTime
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:FIRST_USE_KEY];
}

+ (NSString*)userDefaultsToString
{
    NSData* userData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_KEY];
    DUUser* user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    BOOL firstRun = [[NSUserDefaults standardUserDefaults] boolForKey:FIRST_USE_KEY];
    
    return [NSString stringWithFormat:@"User:\n%@\nFirstRun:%@", user, firstRun ? @"TRUE":@"FALSE"];
}

@end
