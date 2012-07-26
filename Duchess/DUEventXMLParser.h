//
//  DUEventXMLParser.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DUEvent.h"

@interface DUEventXMLParser : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *_eventList;
    
    @private
    DUEvent *_currentEvent;
    NSMutableArray *_currentCategories;
    
    BOOL _isNameTag;
}

@property (nonatomic, retain) NSMutableArray *eventList;

@end
