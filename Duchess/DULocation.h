//
//  DULocation.h
//  Durham Life
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
@property (nonatomic,strong) NSString *address1;
@property (nonatomic,strong) NSString *address2;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *postcode;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *longitude;

@end
