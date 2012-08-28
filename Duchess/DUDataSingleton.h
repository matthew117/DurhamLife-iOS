//
//  DUDataSingleton.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUDataSingleton : NSObject
{
    NSMutableArray *_eventList;
    NSMutableArray *_societyList;
}

@property (nonatomic, strong) NSMutableArray *eventList;

+ (DUDataSingleton*)instance;

- (NSArray*)getAllEvents;
- (NSArray*)getEventsByCollege:(NSString*)college;
- (NSArray*)getEventsByColleges:(NSArray*)collegeList;
- (NSArray*)getEventsBySociety:(NSString*)society;
- (NSArray*)getEventsBySocieties:(NSArray*)societyList;

- (NSArray*)getSocieties;

- (NSArray*)getReviews;

- (NSArray*)getLocations;

@end
