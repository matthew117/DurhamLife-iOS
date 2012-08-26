//
//  DUReview.h
//  Duchess
//
//  Created by Matthew Bates on 20/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUReview : NSObject
{
    NSInteger  _reviewID;
    NSInteger  _eventID;
    NSInteger  _rating;
    NSString  *_comment;
    NSDate    *_timestamp;
}

@property (nonatomic)        NSInteger  reviewID;
@property (nonatomic)        NSInteger  eventID;
@property (nonatomic)        NSInteger  rating;
@property (nonatomic,strong) NSString  *comment;
@property (nonatomic,strong) NSDate    *timestamp;

@end
