//
//  DUDataSingleton.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUDataSingleton : NSObject
{
    NSMutableArray *_eventList;
}

@property (nonatomic, retain) NSMutableArray *eventList;

+ (DUDataSingleton *)instance;

@end
