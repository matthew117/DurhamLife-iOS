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

@interface DUSocietyAboutViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) DUSociety* society;
@property (nonatomic, strong) IBOutlet UILabel *societyNameLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *societyConstitutionScrollView;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *websiteButton;

- (IBAction)emailAction:(UIButton *)sender;
- (IBAction)websiteAction:(UIButton *)sender;

@end
