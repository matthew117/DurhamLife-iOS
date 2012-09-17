//
//  CalendarUtils.h
//  Durham Life
//
//  Created by Jamie Bates on 11/09/2012.
//
//

#import <Foundation/Foundation.h>
#import "DUEvent.h"
#import "DUReview.h"

@interface CalendarUtils : NSObject

+ (NSString*)getEventDateString:(DUEvent*)event;
+ (NSString*)getReviewTimestampString:(DUReview*)review;
+ (BOOL)isDateToday:(NSDate*)date;
+ (BOOL)isDateTomorrow:(NSDate*)date;
+ (BOOL)areDatesEqual:(NSDate*)date1:(NSDate*)date2;
+ (NSDate*)getTodayAsDateOnly;

@end
