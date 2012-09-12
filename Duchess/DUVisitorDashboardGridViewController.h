//
//  DUVisitorDashboardGridViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 12/09/2012.
//
//

#import <UIKit/UIKit.h>

@interface DUVisitorDashboardGridViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *eventsButton;
@property (strong, nonatomic) IBOutlet UIButton *calendarButton;
@property (strong, nonatomic) IBOutlet UIButton *bookmarkedButton;

- (IBAction)eventsAction:(UIButton *)sender;
- (IBAction)calendarAction:(UIButton *)sender;
- (IBAction)bookmarkedAction:(UIButton *)sender;
@end
