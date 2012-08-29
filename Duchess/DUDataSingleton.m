//
//  DUDataSingleton.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUDataSingleton.h"
#import "DUEvent.h"
#import "DUSocietyXMLParser.h"
#import "DUNetworkedDataProvider.h"
#import "SessionHandler.h"

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
    if (_eventList)
    {
        return _eventList;
    }
    else
    {
        _eventList = [NSMutableArray new];
        DUNetworkedDataProvider* apiProvider = [DUNetworkedDataProvider new];
        [apiProvider downloadAndParseEvents:_eventList fromURL:@"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/events.php"];
        return [NSArray arrayWithArray:_eventList];
    }
}
- (NSArray*)getEventsByCollege:(NSString*)college
{
    NSMutableArray* collegeEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
    for (NSObject* o in eventList)
    {
        DUEvent* event = (DUEvent*)o;
        if ([event.associatedCollege isEqualToString:college])
        {
            [collegeEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:collegeEvents];
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
- (NSArray*)getUsersBookmarkedEvents:(DUUser*)user
{
    NSMutableArray* bookmarkedEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
    NSArray* userBookmarks = [SessionHandler getUser].bookmarkedEvents;
    for (NSObject* o in eventList)
    {
        DUEvent* event = (DUEvent*)o;
        if ([DUDataSingleton arrayContainsEventID:userBookmarks :event.eventID])
        {
            [bookmarkedEvents addObject:event];
        }
        
        if (event.eventID == 5 || event.eventID == 8)
        {
            [bookmarkedEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:bookmarkedEvents];
}

+ (BOOL)arrayContainsEventID:(NSArray*)array: (NSInteger)eventID
{
    for (DUEvent* event in array)
    {
        if (event.eventID == eventID) return true;
    }
    return false;
}

- (NSArray*)getSocieties
{
    if (_societyList == nil)
    {
    NSMutableArray* societyList = [NSMutableArray new];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.dur.ac.uk/cs.seg01/duchess/api/v1/societies.php"]];
    NSData *loadedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil)
    {
        NSLog(@"Loaded page from: %@", @"https://www.dur.ac.uk/cs.seg01/duchess/api/v1/societies.php");
        
        DUSocietyXMLParser *xmlHandler = [[DUSocietyXMLParser alloc] init];
        xmlHandler.societyList = societyList;
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:loadedData];
        [parser setDelegate:xmlHandler];
        
        if ([parser parse])
        {
            NSLog(@"XML successfully parsed. eventList should now be populated.");
        }
        else
        {
            NSLog(@"XML Parser Error.");
        }
    }
    else
    {
        NSLog(@"ERROR: %@", error);
    }
        _societyList = societyList;
    return societyList;
    }
    else{
        return _societyList;
    }
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
