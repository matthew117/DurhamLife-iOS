//
//  DUDashboardViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 20/08/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "DUDashboardBackground.h"
#import "DUIndentedLabelView.h"

@interface DUDashboardViewController : UIViewController
{
    NSString *adLink;
}

@property (strong, nonatomic) IBOutlet DUIndentedLabelView *adText;
@property (strong, nonatomic) IBOutlet UIImageView *adImage;
@property (strong, nonatomic) IBOutlet DUDashboardBackground *visitorBoard;
@property (strong, nonatomic) IBOutlet DUDashboardBackground *normalBoard;

@property (strong, nonatomic) IBOutlet UIView *buttonGrid;

- (IBAction)eventsAction:(UIButton *)sender;
- (IBAction)calendarAction:(UIButton *)sender;
- (IBAction)bookmarkedAction:(UIButton *)sender;
- (IBAction)collegeAction:(UIButton *)sender;
- (IBAction)societiesAction:(UIButton *)sender;
- (IBAction)mySocietiesAction:(UIButton *)sender;

- (IBAction)adAction:(id *)sender;

@end
