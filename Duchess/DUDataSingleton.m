//
//  DUDataSingleton.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUDataSingleton.h"

@implementation DUDataSingleton

@synthesize eventList = _eventList;

+ (DUDataSingleton *)instance
{
    static DUDataSingleton *sInstance;
    @synchronized(self)
    {
        if (!sInstance)
        {
            sInstance = [[DUDataSingleton alloc] init];
        }
        return sInstance;
    }
}

- (NSArray*)getAllEvents
{
    return nil;
}
- (NSArray*)getEventsByCollege:(NSString*)college
{
    return nil;
}
- (NSArray*)getEventsByColleges:(NSArray*)collegeList
{
    return nil;
}
- (NSArray*)getEventsBySociety:(NSString*)society
{
    return nil;
}
- (NSArray*)getEventsBySocieties:(NSArray*)societyList
{
    return nil;
}

- (NSArray*)getSocieties
{
    return nil;
}

- (NSArray*)getReviews
{
    return nil;
}

- (NSArray*)getLocations
{
    return nil;
}

@end
