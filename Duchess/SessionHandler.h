//
//  SessionHandler.h
//  Durham Life
//
//  Created by Matthew Bates on 27/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUUser.h"

@interface SessionHandler : NSObject

+ (DUUser*)getUser;
+ (void)saveUser:(DUUser*)user;
+ (void)setDefaults;
+ (BOOL)appOpenedForFirstTime;
+ (void)setAppOpenedForFirstTime;
+ (NSString*)userDefaultsToString;

@end
