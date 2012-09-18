//
//  DUSocietyAboutViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 31/08/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "DUSociety.h"
#import <MessageUI/MessageUI.h>

@interface DUSocietyAboutViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) DUSociety* society;

@end
