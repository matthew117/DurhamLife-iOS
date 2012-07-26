//
//  DUDataSingleton.m
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUDataSingleton.h"

@implementation DUDataSingleton

@synthesize eventList = _eventList;

+ (DUDataSingleton *)instance
{
    static DUDataSingleton *sInstance;
    @synchronized(self)
    {
        if (!sInstance)
        {
            sInstance = [[DUDataSingleton alloc] init];
        }
        return sInstance;
    }
}

@end
