//
//  DuchessAppDelegate.h
//  Duchess
//
//  Created by Matthew Bates on 26/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUAppDelegate : NSObject <UIApplicationDelegate>
{
    
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic) NSInteger currentEvent;

@end
