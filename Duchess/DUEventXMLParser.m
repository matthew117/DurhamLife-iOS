//
//  DUEventXMLParser.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUEventXMLParser.h"

@implementation DUEventXMLParser

@synthesize eventList = _eventList;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"event"])
    {
        _currentEvent = [[DUEvent alloc] init];
    }
    if ([elementName isEqualToString:@"name"]) 
    {
        _isNameTag = true;
    }
    if ([elementName isEqualToString:@"descriptionHeader"])
    {
        
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"event"])
    {
        [_eventList addObject:_currentEvent];
        _currentEvent = nil;
    }
    if ([elementName isEqualToString:@"name"])
    {
        _isNameTag = false;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_isNameTag)
    {
        _currentEvent.name = [NSString stringWithString:string];
    }
}

@end
