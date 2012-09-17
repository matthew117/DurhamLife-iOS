//
//  DUEvent.h
//  Durham Life
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
    
    NSInteger    _eventID;
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
    NSSet     *_categories;
    NSDate    *_startTime;
    NSDate    *_endTime;
}

@property (nonatomic)        NSInteger    eventID;
@property (nonatomic,strong) NSString    *name;
@property (nonatomic,strong) NSString    *descriptionHeader;
@property (nonatomic,strong) NSString    *descriptionBody;
@property (nonatomic,strong) NSDate      *startDate;
@property (nonatomic,strong) NSDate      *endDate;
@property (nonatomic,strong) NSString    *contactTelephoneNumber;
@property (nonatomic,strong) NSString    *contactEmailAddress;
@property (nonatomic,strong) NSString    *accessibilityInformation;
@property (nonatomic,strong) NSString    *linkedWebsiteURL;
@property (nonatomic,strong) NSString    *imageURL;
@property (nonatomic,strong) NSString    *adImageURL;
@property (nonatomic,strong) NSString    *iCalURL;
@property (nonatomic,strong) DULocation  *location;
@property (nonatomic)        NSInteger    numberOfReviews;
@property (nonatomic)        NSInteger    averageReview;
@property (nonatomic,strong) NSString    *associatedCollege;
@property (nonatomic,strong) NSString    *associatedSociety;
@property (nonatomic)        EventScope   eventScope;
@property (nonatomic)        EventPrivacy eventPrivacy;
@property (nonatomic,strong) NSSet       *categories;
@property (nonatomic,strong) NSDate      *startTime;
@property (nonatomic,strong) NSDate      *endTime;

@end
