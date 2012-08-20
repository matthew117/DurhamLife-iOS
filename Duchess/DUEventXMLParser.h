//
//  DUEventXMLParser.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUEvent.h"
#import "DULocation.h"

@interface DUEventXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *_eventList;
    
    @private
    DUEvent *_currentEvent;
    DULocation *_currentLocation;
    NSMutableArray *_currentCategories;
    
    BOOL _isNameTag;
    BOOL _isDescriptionHeaderTag;
    BOOL _isDescriptionBodyTag;
    BOOL _isStartDateTag;
    BOOL _isEndDateTag;
    BOOL _isContactTelephoneNumberTag;
    BOOL _isContactEmailAddressTag;
    BOOL _isAccessibilityInformationTag;
    BOOL _isLinkedWebsiteURLTag;
    BOOL _isImageURLTag;
    BOOL _isAdImageURLTag;
    BOOL _isICalURLTag;
    BOOL _isAddress1Tag;
    BOOL _isAddress2Tag;
    BOOL _isCityTag;
    BOOL _isPostcodeTag;
    BOOL _isLatitudeTag;
    BOOL _isLongitudeTag;
    BOOL _isAverageReviewTag;
    BOOL _isAssociatedCollegeTag;
    BOOL _isAssociatedSocietyTag;
    BOOL _isEventScopeTag;
    BOOL _isEventPrivacyTag;
    BOOL _isCategoryTag;
}

@property (nonatomic, retain) NSMutableArray *eventList;

@end
