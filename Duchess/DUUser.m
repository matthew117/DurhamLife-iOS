//
//  DUUser.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUUser.h"

@implementation DUUser

@synthesize userAffiliation = _userAffiliation;
@synthesize college = _college;
@synthesize categoryPreferences = _categoryPreferences;
@synthesize subscribedSocities = _subscribedSocities;
@synthesize bookmarkedEvents = _bookmarkedEvents;

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self->_userAffiliation = [DUUser integerToAffiliation:[decoder decodeIntegerForKey:@"affiliation"]];
    self->_college = [decoder decodeObjectForKey:@"college"];
    self->_categoryPreferences = [decoder decodeObjectForKey:@"categoryPreferences"];
    self->_subscribedSocities = [decoder decodeObjectForKey:@"subscribedSocieties"];
    self->_bookmarkedEvents = [decoder decodeObjectForKey:@"bookmarkedEvents"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:[DUUser affiliationToInteger:self->_userAffiliation] forKey:@"affiliation"];
    [encoder encodeObject:self->_college forKey:@"college"];
    [encoder encodeObject:self->_categoryPreferences forKey:@"categoryPreferences"];
    [encoder encodeObject:self->_subscribedSocities forKey:@"subscribedSocieties"];
    [encoder encodeObject:self->_bookmarkedEvents forKey:@"bookmarkedEvents"];
}

+ (NSInteger)affiliationToInteger:(UserAffiliation)affiliation
{
    switch (affiliation)
    {
        case USER: return 1;
        case STUDENT: return 2;
        case STAFF: return 3;
        default: return 1;
    }
}

+ (UserAffiliation)integerToAffiliation:(NSInteger)integer
{
    switch (integer)
    {
        case 1: return USER;
        case 2: return STUDENT;
        case 3: return STAFF;
        default:return USER;
    }
}

+ (NSString*)affiliationToString:(UserAffiliation)affiliation
{
    switch (affiliation)
    {
        case USER: return @"Guest";
        case STUDENT: return @"Student";
        case STAFF: return @"Staff";
        default:return @"Guest";
    }
}

- (BOOL)isStaff
{
    
}

- (BOOL)isSubscribedToCategory:(NSString *)category
{
    for(int i = 0; i < _categoryPreferences.count; i++)
    {
        if ([category isEqualToString:[_categoryPreferences objectAtIndex:i]]) return YES;
    }
    
    return NO;
}

- (void)subcribeToCategory:(NSString *)category
{
    if (![self isSubscribedToCategory:category]) [_categoryPreferences addObject:category];
}

- (void)unsubcribeFromCategory:(NSString *)category
{
    if ([self isSubscribedToCategory:category]) [_categoryPreferences removeObject:category];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"Affiliation:%@\nCollege:%@\nCategoryPreferences:%@\nSubscribedEvents:%@\nBookmarkedEvents%@",
            (self->_userAffiliation == STAFF || self->_userAffiliation == STUDENT) ? @"Staff/Student" : @"User",
            self->_college,
            self->_categoryPreferences,
            self->_subscribedSocities,
            self->_bookmarkedEvents];
}

@end
