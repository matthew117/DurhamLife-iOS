//
//  DUDataSingleton.m
//  Durham Life
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUDataSingleton.h"
#import "DUEvent.h"
#import "DUSocietyXMLParser.h"
#import "DUNetworkedDataProvider.h"
#import "SessionHandler.h"
#import "DUReviewXMLParser.h"

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

- (NSArray*)getEventsByColleges:(NSSet*)collegeList
{
    NSMutableArray* collegeEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
    
    for (DUEvent* event in eventList)
    {
        if ([collegeList containsObject: event.associatedCollege])
        {
            [collegeEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:collegeEvents];
}

- (NSArray*)getEventsBySociety:(NSString*)societyName
{
    NSMutableArray* societyEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
    for (DUEvent* event in eventList)
    {
        if ([event.associatedSociety isEqualToString:societyName])
        {
            [societyEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:societyEvents];
}

- (NSArray*)getEventsBySocieties:(NSArray*)societyList
{
    return nil;
}

- (NSArray*)getUsersBookmarkedEvents:(DUUser*)user
{
    NSMutableArray* bookmarkedEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
    NSMutableDictionary* userBookmarks = [SessionHandler getUser].bookmarkedEvents;
    
    for (DUEvent* event in eventList)
    {
        if ([[userBookmarks objectForKey:[NSString stringWithFormat:@"%d",event.eventID]] boolValue])
        {
            [bookmarkedEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:bookmarkedEvents];
}

- (NSArray*)getEventsByDate:(NSDate*)date
{
    NSMutableArray* dateEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
   
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:+1];
    NSDate *dayAfter = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    for (DUEvent* event in eventList)
    {
        NSComparisonResult start = [event.startDate compare:dayAfter];
        NSComparisonResult end = [event.endDate compare:date];
        
        if (start == NSOrderedAscending && (end == NSOrderedDescending || end == NSOrderedSame))
        {
            [dateEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:dateEvents];
}

- (NSArray*)getEventsByCategory:(NSString *)category
{
    NSMutableArray* categoryEvents = [NSMutableArray new];
    NSArray* eventList = [self getAllEvents];
    
    for (DUEvent* event in eventList)
    {
        if ([event.categories containsObject:category])
        {
            [categoryEvents addObject:event];
        }
    }
    return [NSArray arrayWithArray:categoryEvents];
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
                NSLog(@"XML successfully parsed. List should now be populated.");
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
    else return _societyList;
}

- (NSArray*)getReviews:(NSInteger)forEventID
{
    NSMutableArray* reviewList = [NSMutableArray new];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%d", @"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/reviews.php/",forEventID]]];
    NSData *loadedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil)
    {
        NSLog(@"Loaded page from: %@%d", @"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/reviews.php/",forEventID);
        
        DUReviewXMLParser *xmlHandler = [[DUReviewXMLParser alloc] init];
        xmlHandler.reviewList = reviewList;
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:loadedData];
        [parser setDelegate:xmlHandler];
        
        if ([parser parse])
        {
            NSLog(@"XML successfully parsed. List should now be populated.");
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
    
    return reviewList;
}

- (NSArray*)getLocations
{
    return nil;
}

@end
