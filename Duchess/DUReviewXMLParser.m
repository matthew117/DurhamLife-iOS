//
//  DUReviewXMLParser.m
//  Duchess
//
//  Created by Jamie Bates on 25/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUReviewXMLParser.h"
#import "DUReview.h"

@implementation DUReviewXMLParser

@synthesize reviewList = _reviewList;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"review"])
    {
        _currentReview = [[DUReview alloc] init];
        
        NSString *reviewID = [attributeDict objectForKey:@"reviewID"];
        _currentReview.reviewID = [reviewID integerValue];
        
        NSString *eventID = [attributeDict objectForKey:@"eventID"];
        _currentReview.eventID = [eventID integerValue];
    }
    else if ([elementName isEqualToString:@"rating"])
    {
        _isRatingTag = true;
    }
    else if ([elementName isEqualToString:@"post"])
    {
        _isCommentTag = true;
    }
    else if ([elementName isEqualToString:@"timestamp"])
    {
        _isTimestampTag = true;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"review"])
    {
        [_reviewList addObject:_currentReview];
        _currentReview = nil;
    }
    else if ([elementName isEqualToString:@"rating"])
    {
        _isRatingTag = false;
    }
    else if ([elementName isEqualToString:@"post"])
    {
        _isCommentTag = false;
    }
    else if ([elementName isEqualToString:@"timestamp"])
    {
        _isTimestampTag = false;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_isRatingTag)
    {
        NSString *rating = [NSString stringWithString:string];
        _currentReview.rating = [rating integerValue];
    }
    else if (_isCommentTag)
    {
        _currentReview.comment = [NSString stringWithString:string];
    }
    else if (_isTimestampTag)
    {
        _currentReview.timestamp = [NSString stringWithString:string];
    }
}

@end
