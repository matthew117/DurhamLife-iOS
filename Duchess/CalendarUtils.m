//
//  CalendarUtils.m
//  Durham Life
//
//  Created by Jamie Bates on 11/09/2012.
//
//

#import "CalendarUtils.h"
#import "DUEvent.h"

@implementation CalendarUtils

+ (NSString*)getEventDateString:(DUEvent*)event
{
    NSString *date = @"";
    
    if ([event.endDate compare:[NSDate date]] == NSOrderedAscending) date = @"This event has ended";
    else
    {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"d MMMM"];
        
        if ([self areDatesEqual:event.startDate:event.endDate])
        {
            if ([self isDateToday:event.startDate]) date = @"Today";
            else if ([self isDateTomorrow:event.startDate]) date = @"Tomorrow";
            else date = [formatter stringFromDate:event.startDate];
        }
        else
        {
            if ([self isDateToday:event.startDate])
            {
                if ([self isDateTomorrow:event.endDate]) date = @"Today & Tomorrow";
                else date = [NSString stringWithFormat:@"Today until %@", [formatter stringFromDate:event.endDate]];
            }
            else date = [NSString stringWithFormat:@"%@ until %@", [formatter stringFromDate:event.startDate], [formatter stringFromDate:event.endDate]];
        }
    }
    
    return date;
}

+ (NSString*)getReviewTimestampString:(DUReview*)review
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:review.timestamp];
    
    if (interval < 60)
    {
        int seconds = interval;
        return [NSString stringWithFormat:@"%d second%@ ago", seconds, seconds < 2 ? @"" : @"s"];
    }
    else if (interval < 60 * 60)
    {
        int minutes = interval / 60;
        return [NSString stringWithFormat:@"%d minute%@ ago", minutes, minutes < 2 ? @"" : @"s"];
    }
    else if (interval < 60 * 60 * 24)
    {
        int hours = interval / (60 * 60);
        return [NSString stringWithFormat:@"%d hour%@ ago", hours, hours < 2 ? @"" : @"s"];
    }
    else
    {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"d MMMM yyyy HH:mm"];
        
        return [formatter stringFromDate:review.timestamp];
    }
}

+ (BOOL)isDateToday:(NSDate*)date
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents* dateComps = [calendar components:flags fromDate:date];
    date = [calendar dateFromComponents:dateComps];
    
    NSDateComponents* todayComps = [calendar components:flags fromDate:[NSDate date]];
    NSDate* today = [calendar dateFromComponents:todayComps];
    
    return [today compare:date] == NSOrderedSame;
}

+ (BOOL)isDateTomorrow:(NSDate*)date
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents* dateComps = [calendar components:flags fromDate:date];
    date = [calendar dateFromComponents:dateComps];
    
    NSDateComponents* tomorrowComps = [calendar components:flags fromDate:[NSDate date]];
    NSDate* tomorrow = [calendar dateFromComponents:tomorrowComps];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1];
    tomorrow = [calendar dateByAddingComponents:comps toDate:tomorrow options:0];
    
    return [tomorrow compare:date] == NSOrderedSame;
}

+ (BOOL)areDatesEqual:(NSDate*)date1:(NSDate*)date2
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents* date1Comps = [calendar components:flags fromDate:date1];
    date1 = [calendar dateFromComponents:date1Comps];
    
    NSDateComponents* date2Comps = [calendar components:flags fromDate:date2];
    date2 = [calendar dateFromComponents:date2Comps];
    
    return [date1 compare:date2] == NSOrderedSame;
}

@end
