//
//  DUDashboardViewController.h
//  Duchess
//
//  Created by Matthew Bates on 20/08/2012.
//
//

#import <UIKit/UIKit.h>

@interface DUDashboardViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *adButton;

- (IBAction)browseButton:(UIButton *)sender;
- (IBAction)collegeEvents:(UIButton *)sender;
- (IBAction)societiesButton:(UIButton *)sender;
- (IBAction)bookmarkedButton:(UIButton *)sender;
- (IBAction)mySocietiesButton:(UIButton *)sender;

- (void)settingsButton:(UIButton *)sender;
- (void)aboutButton:(UIButton *)sender;

@end
