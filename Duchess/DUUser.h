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
@property (nonatomic,strong) NSString  *forename;
@property (nonatomic,strong) NSString  *surname;
@property (nonatomic,strong) NSString  *email;
@property (nonatomic,strong) NSString  *department;
@property (nonatomic,strong) NSString  *college;
@property (nonatomic,strong) NSMutableArray *categoryPreferences;
@property (nonatomic,strong) NSMutableArray *subscribedSocities;

@end
