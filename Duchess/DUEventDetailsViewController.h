//
//  DUEventDetailsViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 27/07/2012.
//  Copyright 2012 Durham University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "DUEvent.h"

@interface DUEventDetailsViewController : UITableViewController <MFMailComposeViewControllerDelegate>
{
    UIImage* eventImage;
}

@property (nonatomic, strong) DUEvent* event;

@end
