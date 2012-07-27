//
//  DUEventXMLParser.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUEventXMLParser.h"
#import "DUEvent.h"

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
    else if ([elementName isEqualToString:@"name"]) 
    {
        _isNameTag = true;
    }
    else if ([elementName isEqualToString:@"descriptionHeader"])
    {
        _isDescriptionHeaderTag = true;
    }
    else if ([elementName isEqualToString:@"descriptionBody"])
    {
        _isDescriptionBodyTag = true;
    }
    else if ([elementName isEqualToString:@"startDate"])
    {
        _isStartDateTag = true;
    }
    else if ([elementName isEqualToString:@"endDate"])
    {
        _isEndDateTag = true;
    }
    else if ([elementName isEqualToString:@"contactTelephoneNumber"])
    {
        _isContactTelephoneNumberTag = true;
    }
    else if ([elementName isEqualToString:@"contactEmailAddress"])
    {
        _isContactEmailAddressTag = true;
    }
    else if ([elementName isEqualToString:@"accessibilityInformation"])
    {
        _isAccessibilityInformationTag = true;
    }
    else if ([elementName isEqualToString:@"webAddress"])
    {
        _isLinkedWebsiteURLTag = true;
    }
    else if ([elementName isEqualToString:@"imageURL"])
    {
        _isImageURLTag = true;
    }
    else if ([elementName isEqualToString:@"adImageURL"])
    {
        _isAdImageURLTag = true;
    }
    else if ([elementName isEqualToString:@"iCalURL"])
    {
        _isICalURLTag = true;
    }
    else if ([elementName isEqualToString:@"address1"])
    {
        _isAddress1Tag = true;
    }
    else if ([elementName isEqualToString:@"address2"])
    {
        _isAddress2Tag = true;
    }
    else if ([elementName isEqualToString:@"city"])
    {
        _isCityTag = true;
    }
    else if ([elementName isEqualToString:@"postcode"])
    {
        _isPostcodeTag = true;
    }
    else if ([elementName isEqualToString:@"latitude"])
    {
        _isLatitudeTag = true;
    }
    else if ([elementName isEqualToString:@"longitude"])
    {
        _isLongitudeTag = true;
    }
    else if ([elementName isEqualToString:@"reviewScore"])
    {
        _isAverageReviewTag = true;
    }
    else if ([elementName isEqualToString:@"associatedCollege"])
    {
        _isAssociatedCollegeTag = true;
    }
    else if ([elementName isEqualToString:@"associatedSociety"])
    {
        _isAssociatedSocietyTag = true;
    }
    else if ([elementName isEqualToString:@"eventScope"])
    {
        _isEventScopeTag = true;
    }
    else if ([elementName isEqualToString:@"category"])
    {
        _isCategoryTag = true;
    }
    else if ([elementName isEqualToString:@"tags"])
    {
        _currentCategories = [[NSMutableArray alloc] init];
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
    else if ([elementName isEqualToString:@"name"])
    {
        _isNameTag = false;
    }
    else if ([elementName isEqualToString:@"descriptionHeader"])
    {
        _isDescriptionHeaderTag = false;
    }
    else if ([elementName isEqualToString:@"descriptionBody"])
    {
        _isDescriptionBodyTag = false;
    }
    else if ([elementName isEqualToString:@"startDate"])
    {
        _isStartDateTag = false;
    }
    else if ([elementName isEqualToString:@"endDate"])
    {
        _isEndDateTag = false;
    }
    else if ([elementName isEqualToString:@"contactTelephoneNumber"])
    {
        _isContactTelephoneNumberTag = false;
    }
    else if ([elementName isEqualToString:@"contactEmailAddress"])
    {
        _isContactEmailAddressTag = false;
    }
    else if ([elementName isEqualToString:@"accessibilityInformation"])
    {
        _isAccessibilityInformationTag = false;
    }
    else if ([elementName isEqualToString:@"webAddress"])
    {
        _isLinkedWebsiteURLTag = false;
    }
    else if ([elementName isEqualToString:@"imageURL"])
    {
        _isImageURLTag = false;
    }
    else if ([elementName isEqualToString:@"adImageURL"])
    {
        _isAdImageURLTag = false;
    }
    else if ([elementName isEqualToString:@"iCalURL"])
    {
        _isICalURLTag = false;
    }
    else if ([elementName isEqualToString:@"address1"])
    {
        _isAddress1Tag = false;
    }
    else if ([elementName isEqualToString:@"address2"])
    {
        _isAddress2Tag = false;
    }
    else if ([elementName isEqualToString:@"city"])
    {
        _isCityTag = false;
    }
    else if ([elementName isEqualToString:@"postcode"])
    {
        _isPostcodeTag = false;
    }
    else if ([elementName isEqualToString:@"latitude"])
    {
        _isLatitudeTag = false;
    }
    else if ([elementName isEqualToString:@"longitude"])
    {
        _isLongitudeTag = false;
    }
    else if ([elementName isEqualToString:@"reviewScore"])
    {
        _isAverageReviewTag = false;
    }
    else if ([elementName isEqualToString:@"associatedCollege"])
    {
        _isAssociatedCollegeTag = false;
    }
    else if ([elementName isEqualToString:@"associatedSociety"])
    {
        _isAssociatedSocietyTag = false;
    }
    else if ([elementName isEqualToString:@"eventScope"])
    {
        _isEventScopeTag = false;
    }
    else if ([elementName isEqualToString:@"category"])
    {
        _isCategoryTag = false;
    }
    else if ([elementName isEqualToString:@"tags"])
    {
        _currentEvent.categories = _currentCategories;
        _currentCategories = nil;
        [_currentCategories release];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_isNameTag)
    {
        _currentEvent.name = [NSString stringWithString:string];
    }
    else if (_isDescriptionHeaderTag)
    {
        _currentEvent.descriptionHeader = [NSString stringWithString:string];
    }
    else if (_isDescriptionBodyTag)
    {
        _currentEvent.descriptionBody = [NSString stringWithString:string];
    }
    else if (_isStartDateTag)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _currentEvent.endDate = [dateFormatter dateFromString:string];
    }
    else if (_isEndDateTag)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _currentEvent.startDate = [dateFormatter dateFromString:string];
    }
    else if (_isContactTelephoneNumberTag)
    {
        _currentEvent.contactTelephoneNumber = [NSString stringWithString:string];
    }
    else if (_isContactEmailAddressTag)
    {
        _currentEvent.contactEmailAddress = [NSString stringWithString:string];
    }
    else if (_isAccessibilityInformationTag)
    {
        _currentEvent.accessibilityInformation = [NSString stringWithString:string];
    }
    else if (_isLinkedWebsiteURLTag)
    {
        _currentEvent.linkedWebsiteURL = [NSString stringWithString:string];
    }
    else if (_isImageURLTag)
    {
        _currentEvent.imageURL = [NSString stringWithString:string];
    }
    else if (_isAdImageURLTag)
    {
        _currentEvent.adImageURL = [NSString stringWithString:string];
    }
    else if (_isAddress1Tag)
    {
        _currentEvent.address1 = [NSString stringWithString:string];
    }
    else if (_isAddress2Tag)
    {
        _currentEvent.address2 = [NSString stringWithString:string];
    }
    else if (_isCityTag)
    {
        _currentEvent.city = [NSString stringWithString:string];
    }
    else if (_isPostcodeTag)
    {
        _currentEvent.postcode = [NSString stringWithString:string];
    }
    else if (_isLatitudeTag)
    {
        _currentEvent.latitude = [NSString stringWithString:string];
    }
    else if (_isLongitudeTag)
    {
        _currentEvent.longitude = [NSString stringWithString:string];
    }
    else if (_isAverageReviewTag)
    {
        _currentEvent.averageReview = [string integerValue];
    }
    else if (_isAssociatedCollegeTag)
    {
        _currentEvent.associatedCollege = [NSString stringWithString:string];
    }
    else if (_isAssociatedSocietyTag)
    {
        _currentEvent.associatedSociety = [NSString stringWithString:string];
    }
    else if (_isEventScopeTag)
    {
        if ([string isEqualToString:@"Public"]) _currentEvent.eventScope = PUBLIC;
        if ([string isEqualToString:@"University"]) _currentEvent.eventScope = UNIVERSITY;
        if ([string isEqualToString:@"College"]) _currentEvent.eventScope = COLLEGE;
        if ([string isEqualToString:@"Society"]) _currentEvent.eventScope = SOCIETY;
    }
}

@end
