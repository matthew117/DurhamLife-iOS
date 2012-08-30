//
//  DUUser.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum userAffiliation
{
    USER,
    STUDENT,
    STAFF,
} UserAffiliation;

@interface DUUser : NSObject <NSCoding>
{
    UserAffiliation _userAffiliation;
    NSString  *_college;
    NSMutableArray *_categoryPreferences;
    NSMutableArray *_subscribedSocities;
    NSMutableDictionary *_bookmarkedEvents;
}

@property (nonatomic) UserAffiliation userAffiliation;
@property (nonatomic,strong) NSString  *college;
@property (nonatomic,strong) NSMutableArray *categoryPreferences;
@property (nonatomic,strong) NSMutableArray *subscribedSocities;
@property (nonatomic,strong) NSMutableDictionary *bookmarkedEvents;

+ (NSInteger)affiliationToInteger:(UserAffiliation)affiliation;
+ (UserAffiliation)integerToAffiliation:(NSInteger)integer;
+ (NSString*)affiliationToString:(UserAffiliation)affiliation;
- (BOOL)isStaff;
- (BOOL)isSubscribedToCategory:(NSString*)category;
- (void)subcribeToCategory:(NSString*)category;
- (void)unsubcribeFromCategory:(NSString*)category;

@end
