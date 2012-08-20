//
//  DULocation.h
//  Duchess
//
//  Created by Matthew Bates on 20/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DULocation : NSObject
{
    NSInteger _locationID;
    NSString *_address1;
    NSString *_address2;
    NSString *_city;
    NSString *_postcode;
    NSString *_latitude;
    NSString *_longitude;
}

@property (nonatomic) NSInteger locationID;
@property (nonatomic,retain) NSString *address1;
@property (nonatomic,retain) NSString *address2;
@property (nonatomic,retain) NSString *city;
@property (nonatomic,retain) NSString *postcode;
@property (nonatomic,retain) NSString *latitude;
@property (nonatomic,retain) NSString *longitude;

@end
