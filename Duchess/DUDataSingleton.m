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
        NSLog(@"college: %@\nexpected:%@\n",event.associatedCollege, college);
        if ([event.associatedCollege isEqualToString:college])
        {
            NSLog(@"Found a college event");
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
