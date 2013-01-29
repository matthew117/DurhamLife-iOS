//
//  DUNetworkedDataProvider.m
//  Durham Life
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUNetworkedDataProvider.h"
#import "DUEventXMLParser.h"

#import "SBJson.h"

@implementation DUNetworkedDataProvider

- (void)downloadAndParseEvents:(NSMutableArray *)eventList fromURL:(NSString *)URL
{
    // Should be called on the background thread
    // Caller should check to see whether network access is available before calling this function
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSData *loadedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error == nil)
    {
        NSLog(@"Loaded page from: %@", URL);
        
        /*
        DUEventXMLParser *xmlHandler = [[DUEventXMLParser alloc] init];
        xmlHandler.eventList = eventList;
        
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
         */
        
        SBJsonParser *parser = [SBJsonParser new];
        NSDictionary *jsonDict = [parser objectWithData:loadedData];
        
        for (NSDictionary *event in jsonDict)
        {
            DUEvent *currentEvent = [DUEvent new];
            [currentEvent setName:[event objectForKey:@"title"]];
            [currentEvent setDescriptionHeader:[event objectForKey:@"summary"]];
            [currentEvent setDescriptionBody:[event objectForKey:@"description"]];
            currentEvent.imageURL = [event objectForKey:@"image_url"];
            currentEvent.contactEmailAddress = [event objectForKey:@"contact_email"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'+0000'"];
            currentEvent.startDate = [dateFormatter dateFromString:[event objectForKey:@"start"]];
            currentEvent.startDate = [dateFormatter dateFromString:[event objectForKey:@"end"]];
            
            DULocation *currentLocation = [DULocation new];
            [currentLocation setAddress1:[event objectForKey:@"venue"]];
            [currentEvent setLocation:currentLocation];
            
            [eventList addObject:currentEvent];
        }
    }
    else
    {
        NSLog(@"ERROR: %@", error);
    }
}

@end
