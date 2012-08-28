//
//  DUSocietyXMLParser.m
//  Duchess
//
//  Created by Matthew Bates on 28/08/2012.
//
//

#import "DUSocietyXMLParser.h"

@implementation DUSocietyXMLParser

@synthesize societyList = _societyList;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"society"])
    {
        _currentSociety = [[DUSociety alloc] init];
        
        NSString *societyID = [attributeDict objectForKey:@"societyID"];
        _currentSociety.societyID = [societyID integerValue];
    }
    else if ([elementName isEqualToString:@"name"])
    {
        _isNameTag = true;
    }
    else if ([elementName isEqualToString:@"constitution"])
    {
        _isConstitutionTag = true;
    }
    else if ([elementName isEqualToString:@"website"])
    {
        _isWebsiteTag = true;
    }
    else if ([elementName isEqualToString:@"email"])
    {
        _isEmailTag = true;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"society"])
    {
        [_societyList addObject:_currentSociety];
        _currentSociety = nil;
    }
    else if ([elementName isEqualToString:@"name"])
    {
        _isNameTag = false;
    }
    else if ([elementName isEqualToString:@"constitution"])
    {
        _isConstitutionTag = false;
    }
    else if ([elementName isEqualToString:@"website"])
    {
        _isWebsiteTag = false;
    }
    else if ([elementName isEqualToString:@"email"])
    {
        _isEmailTag = false;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_isNameTag)
    {
        _currentSociety.name = [NSString stringWithString:string];
    }
    else if (_isConstitutionTag)
    {
        _currentSociety.constitution = [NSString stringWithString:string];
    }
    else if (_isWebsiteTag)
    {
        _currentSociety.website = [NSString stringWithString:string];
    }
    else if (_isEmailTag)
    {
        _currentSociety.email = [NSString stringWithString:string];
    }
}

@end
