//
//  DUEvent.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DULocation.h"

typedef enum eventScopeEnum
{
    PUBLIC,
    UNIVERSITY,
    COLLEGE,
    SOCIETY
} EventScope;

typedef enum eventPrivacyEnum
{
    OPEN,
    PRIVATE
} EventPrivacy;

@interface DUEvent : NSObject
{
    // Instance variables
    
    NSString    *_name;
    NSString    *_descriptionHeader;
    NSString    *_descriptionBody;
    NSDate      *_startDate;
    NSDate      *_endDate;
    NSString    *_contactTelephoneNumber;
    NSString    *_contactEmailAddress;
    NSString    *_accessibilityInformation;
    NSString    *_linkedWebsiteURL;
    NSString    *_imageURL;
    NSString    *_adImageURL;
    NSString    *_iCalURL;
    DULocation  *_location;
    NSInteger    _numberOfReviews;
    NSInteger    _averageReview;
    NSString    *_associatedCollege;
    NSString    *_associatedSociety;
    EventScope   _eventScope;
    EventPrivacy _eventPrivacy;
    NSArray     *_categories;
}

@property (nonatomic,retain) NSString    *name;
@property (nonatomic,retain) NSString    *descriptionHeader;
@property (nonatomic,retain) NSString    *descriptionBody;
@property (nonatomic,retain) NSDate      *startDate;
@property (nonatomic,retain) NSDate      *endDate;
@property (nonatomic,retain) NSString    *contactTelephoneNumber;
@property (nonatomic,retain) NSString    *contactEmailAddress;
@property (nonatomic,retain) NSString    *accessibilityInformation;
@property (nonatomic,retain) NSString    *linkedWebsiteURL;
@property (nonatomic,retain) NSString    *imageURL;
@property (nonatomic,retain) NSString    *adImageURL;
@property (nonatomic,retain) NSString    *iCalURL;
@property (nonatomic,retain) DULocation  *location;
@property (nonatomic)        NSInteger    numberOfReviews;
@property (nonatomic)        NSInteger    averageReview;
@property (nonatomic,retain) NSString    *associatedCollege;
@property (nonatomic,retain) NSString    *associatedSociety;
@property (nonatomic)        EventScope   eventScope;
@property (nonatomic)        EventPrivacy eventPrivacy;
@property (nonatomic,retain) NSArray     *categories;

@end
