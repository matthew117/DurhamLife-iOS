//
//  DUDashboardViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 20/08/2012.
//
//

#import <UIKit/UIKit.h>

@interface DUDashboardViewController : UIViewController
{
    NSString *adLink;
}

@property (strong, nonatomic) IBOutlet UIButton *adButton;
@property (strong, nonatomic) IBOutlet UILabel *adText;
@property (strong, nonatomic) IBOutlet UIImageView *adImage;

@property (strong, nonatomic) IBOutlet UIButton *browseButton;
@property (strong, nonatomic) IBOutlet UIButton *calendarButton;
@property (strong, nonatomic) IBOutlet UIButton *bookmarkedButton;
@property (strong, nonatomic) IBOutlet UIButton *collegeButton;
@property (strong, nonatomic) IBOutlet UIButton *societiesButton;
@property (strong, nonatomic) IBOutlet UIButton *mySocietiesButton;


- (IBAction)browseAction:(UIButton *)sender;
- (IBAction)collegeAction:(UIButton *)sender;
- (IBAction)societiesAction:(UIButton *)sender;
- (IBAction)bookmarkedAction:(UIButton *)sender;
- (IBAction)mySocietiesAction:(UIButton *)sender;
- (IBAction)calendarAction:(UIButton *)sender;

- (void)settingsButton:(UIButton *)sender;
- (void)aboutButton:(UIButton *)sender;
- (IBAction)adAction:(UIButton *)sender;

@end
