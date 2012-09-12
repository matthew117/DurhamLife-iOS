//
//  DUUser.h
//  Durham Life
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum userAffiliation
{
    VISITOR,
    STUDENT,
    ALUMNI,
    STAFF,
} UserAffiliation;

@interface DUUser : NSObject <NSCoding>
{
    UserAffiliation _userAffiliation;
    NSMutableSet *_colleges;
    NSMutableSet *_categoryPreferences;
    NSMutableArray *_subscribedSocities;
    NSMutableDictionary *_bookmarkedEvents;
}

@property (nonatomic) UserAffiliation userAffiliation;
@property (nonatomic,strong) NSMutableSet *colleges;
@property (nonatomic,strong) NSMutableSet *categoryPreferences;
@property (nonatomic,strong) NSMutableArray *subscribedSocities;
@property (nonatomic,strong) NSMutableDictionary *bookmarkedEvents;

- (NSString*)getPrimaryCollege;
- (void)setPrimaryCollege:(NSString*)college;

+ (NSInteger)affiliationToInteger:(UserAffiliation)affiliation;
+ (UserAffiliation)integerToAffiliation:(NSInteger)integer;
+ (NSString*)affiliationToString:(UserAffiliation)affiliation;

- (BOOL)isStudent;
- (BOOL)isStaff;
- (BOOL)isAlumni;
- (BOOL)isGuest;

- (BOOL)isSubscribedToCategory:(NSString*)category;
- (void)subcribeToCategory:(NSString*)category;
- (void)unsubcribeFromCategory:(NSString*)category;

- (BOOL)isSubscribedToCollege:(NSString*)college;
- (void)subcribeToCollege:(NSString*)college;
- (void)unsubcribeFromCollege:(NSString*)college;

- (BOOL)isSubscribedToSociety:(NSString *)society;
- (void)subscribeToSociety:(NSString*)society;
- (void)unsubscribeFromSociety:(NSString *)society;

@end
