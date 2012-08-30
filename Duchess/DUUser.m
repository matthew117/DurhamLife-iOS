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
@synthesize colleges = _colleges;
@synthesize categoryPreferences = _categoryPreferences;
@synthesize subscribedSocities = _subscribedSocities;
@synthesize bookmarkedEvents = _bookmarkedEvents;

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    self->_userAffiliation = [DUUser integerToAffiliation:[decoder decodeIntegerForKey:@"affiliation"]];
    self->_colleges = [decoder decodeObjectForKey:@"college"];
    self->_categoryPreferences = [decoder decodeObjectForKey:@"categoryPreferences"];
    self->_subscribedSocities = [decoder decodeObjectForKey:@"subscribedSocieties"];
    self->_bookmarkedEvents = [decoder decodeObjectForKey:@"bookmarkedEvents"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:[DUUser affiliationToInteger:self->_userAffiliation] forKey:@"affiliation"];
    [encoder encodeObject:self->_colleges forKey:@"college"];
    [encoder encodeObject:self->_categoryPreferences forKey:@"categoryPreferences"];
    [encoder encodeObject:self->_subscribedSocities forKey:@"subscribedSocieties"];
    [encoder encodeObject:self->_bookmarkedEvents forKey:@"bookmarkedEvents"];
}

- (NSString*)getPrimaryCollege
{
    if ([_colleges count] > 0)
    {
        return [_colleges anyObject];
    }
    else return nil;
}

+ (NSInteger)affiliationToInteger:(UserAffiliation)affiliation
{
    switch (affiliation)
    {
        case GUEST: return 1;
        case STUDENT: return 2;
        case STAFF: return 3;
        default: return 1;
    }
}

+ (UserAffiliation)integerToAffiliation:(NSInteger)integer
{
    switch (integer)
    {
        case 1: return GUEST;
        case 2: return STUDENT;
        case 3: return STAFF;
        default:return GUEST;
    }
}

+ (NSString*)affiliationToString:(UserAffiliation)affiliation
{
    switch (affiliation)
    {
        case GUEST: return @"Guest";
        case STUDENT: return @"Student";
        case STAFF: return @"Staff";
        default:return @"Guest";
    }
}

- (BOOL)isStudent
{
    return _userAffiliation == STUDENT;
}

- (BOOL)isStaff
{
    return _userAffiliation == STAFF;
}

- (BOOL)isGuest
{
    return _userAffiliation == GUEST;
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

- (BOOL)isSubscribedToCollege:(NSString*)college
{
    return NO;
}

- (void)subcribeToCollege:(NSString*)college
{
    
}

- (void)unsubcribeFromCollege:(NSString*)college
{
    
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"Affiliation:%@\nCollege:%@\nCategoryPreferences:%@\nSubscribedEvents:%@\nBookmarkedEvents%@",
            [DUUser affiliationToString:self->_userAffiliation],
            self->_colleges,
            self->_categoryPreferences,
            self->_subscribedSocities,
            self->_bookmarkedEvents];
}

@end
