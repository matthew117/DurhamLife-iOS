//
//  DUSociety.h
//  Duchess
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
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *website;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *constitution;

@end
