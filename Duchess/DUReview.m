//
//  DUReview.m
//  Durham Life
//
//  Created by Matthew Bates on 20/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import "DUReview.h"

@implementation DUReview

@synthesize reviewID = _reviewID;
@synthesize eventID = _eventID;
@synthesize rating = _rating;
@synthesize comment = _comment;
@synthesize timestamp = _timestamp;

- (NSString*)description
{
    return [NSString stringWithFormat:@"Time posted: %@\nComment: %@\nRating: %d",
            self->_timestamp,
            self->_comment.length < 50 ? self->_comment :
            [NSString stringWithFormat:@"%@...", [self->_comment substringToIndex:50]],
            self->_rating];
}

@end
