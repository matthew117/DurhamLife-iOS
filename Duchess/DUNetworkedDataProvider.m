//
//  DUNetworkedDataProvider.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUNetworkedDataProvider.h"
#import "DUEventXMLParser.h"

@implementation DUNetworkedDataProvider

- (void)downloadAndParseEvents:(NSMutableArray *)eventList fromURL:(NSString *)URL target:(id)target selector:(SEL)selector
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
        
        DUEventXMLParser *xmlHandler = [[DUEventXMLParser alloc] init];
        xmlHandler.eventList = eventList;
        
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
    
    [target performSelectorOnMainThread:selector withObject:eventList waitUntilDone:YES];
}

@end
