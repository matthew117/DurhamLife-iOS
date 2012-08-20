//
//  DUUser.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DUUser : NSObject
{
    NSInteger  _userID;
    NSString  *_forename;
    NSString  *_surname;
    NSString  *_email;
    NSString  *_department;
    NSString  *_college;
    NSMutableArray *_categoryPreferences;
    NSMutableArray *_subscribedSocities;
}

@property (nonatomic)        NSInteger  userID;
@property (nonatomic,retain) NSString  *forename;
@property (nonatomic,retain) NSString  *surname;
@property (nonatomic,retain) NSString  *email;
@property (nonatomic,retain) NSString  *department;
@property (nonatomic,retain) NSString  *college;
@property (nonatomic,retain) NSMutableArray *categoryPreferences;
@property (nonatomic,retain) NSMutableArray *subscribedSocities;

@end
