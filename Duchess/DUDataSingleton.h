//
//  DUDataSingleton.h
//  Durham Life
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUUser.h"

@interface DUDataSingleton : NSObject
{
    NSMutableArray *_eventList;
    NSMutableArray *_societyList;
}

@property (nonatomic, strong) NSMutableArray *eventList;

+ (DUDataSingleton*)instance;

- (NSArray*)getAllEvents;
- (NSArray*)getEventsByCollege:(NSString*)college;
- (NSArray*)getEventsByColleges:(NSSet*)collegeList;
- (NSArray*)getEventsBySociety:(NSString*)societyName;
- (NSArray*)getEventsBySocieties:(NSArray*)societyList;
- (NSArray*)getUsersBookmarkedEvents:(DUUser*)user;
- (NSArray*)getEventsByDate:(NSDate*)date;
- (NSArray*)getEventsByCategory:(NSString *)category;

- (NSArray*)getSocieties;

- (NSArray*)getReviews:(NSInteger)forEventID;

- (NSArray*)getLocations;

@end
