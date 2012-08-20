//
//  DUReview.h
//  Duchess
//
//  Created by App Dev on 20/08/2012.
//
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
@property (nonatomic,retain) NSString  *comment;
@property (nonatomic,retain) NSDate    *timestamp;
@end
