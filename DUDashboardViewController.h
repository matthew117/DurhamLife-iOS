//
//  DUDashboardViewController.h
//  Duchess
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

- (IBAction)browseButton:(UIButton *)sender;
- (IBAction)collegeEvents:(UIButton *)sender;
- (IBAction)societiesButton:(UIButton *)sender;
- (IBAction)bookmarkedButton:(UIButton *)sender;
- (IBAction)mySocietiesButton:(UIButton *)sender;
- (IBAction)calendarButton:(UIButton *)sender;

- (void)settingsButton:(UIButton *)sender;
- (void)aboutButton:(UIButton *)sender;
- (IBAction)adAction:(UIButton *)sender;

@end
