//
//  DUReviewXMLParser.h
//  Duchess
//
//  Created by Jamie Bates on 25/08/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUReview.h"

@interface DUReviewXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *_reviewList;
    
    @private
    DUReview *_currentReview;
    
    BOOL _isRatingTag;
    BOOL _isCommentTag;
    BOOL _isTimestampTag;
}

@property (nonatomic, strong) NSMutableArray *reviewList;

@end
