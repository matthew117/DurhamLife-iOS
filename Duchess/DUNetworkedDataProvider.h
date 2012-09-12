//
//  DUNetworkedDataProvider.h
//  Durham Life
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUNetworkedDataProvider : NSObject
{
    
}

- (void)downloadAndParseEvents:(NSMutableArray *)eventList fromURL:(NSString *)URL;

@end
