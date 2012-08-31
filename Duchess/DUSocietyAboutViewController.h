//
//  DUSocietyAboutViewController.h
//  Duchess
//
//  Created by Matthew Bates on 31/08/2012.
//
//

#import <UIKit/UIKit.h>
#import "DUSociety.h"
#import <MessageUI/MessageUI.h>

@interface DUSocietyAboutViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) DUSociety* society;

@end
