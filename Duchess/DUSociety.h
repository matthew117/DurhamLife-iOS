//
//  DUSociety.h
//  Durham Life
//
//  Created by Matthew Bates on 20/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUSociety : NSObject
{
    NSInteger _societyID;
    NSString *_name;
    NSString *_website;
    NSString *_email;
    NSString *_constitution;
}

@property (nonatomic) NSInteger societyID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *website;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *constitution;

@end
