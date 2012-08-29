//
//  DUDashboardViewController.m
//  Duchess
//
//  Created by Matthew Bates on 20/08/2012.
//
//

#import "DUDashboardViewController.h"
#import "DUAboutViewController.h"
#import "DUCollegeEventsViewController.h"
#import "DUSocietyListViewController.h"
#import "SessionHandler.h"
#import "DUEventListViewController.h"
#import "DUSettingsViewController.h"
#import "DUBookmarkedViewController.h"

@interface DUDashboardViewController ()

@end

@implementation DUDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Durham Life";
    
    [SessionHandler setDefaults];
    if ([SessionHandler appOpenedForFirstTime])
    {
        NSLog(@"This is a first time run.");
        NSLog(@"%@",[SessionHandler userDefaultsToString]);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)browseButton:(UIButton *)sender
{
    DUEventListViewController* eventListController = [[DUEventListViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    [self.navigationController pushViewController:eventListController animated:YES];
}

- (IBAction)aboutButton:(UIButton *)sender
{
    DUAboutViewController *aboutView = [[DUAboutViewController alloc] init];
    [self presentModalViewController:aboutView animated:YES];
}

- (IBAction)collegeEvents:(UIButton *)sender
{
    DUCollegeEventsViewController* collegeListController = [[DUCollegeEventsViewController alloc] initWithNibName:@"DUCollegeEventsViewController" bundle:nil];
    [self.navigationController pushViewController:collegeListController animated:YES];

}

- (IBAction)societiesButton:(UIButton *)sender
{
    DUSocietyListViewController* societyListController = [[DUSocietyListViewController alloc] initWithNibName:@"DUSocietyListViewController" bundle:nil];
    [self.navigationController pushViewController:societyListController animated:YES];
}

- (IBAction)settingsButton:(UIButton *)sender
{
    DUSettingsViewController* settingsController = [[DUSettingsViewController alloc] initWithNibName:@"DUSettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsController animated:YES];
}

- (IBAction)bookmarkedButton:(UIButton *)sender
{
    DUBookmarkedViewController* bookmarkController = [[DUBookmarkedViewController alloc] initWithNibName:@"DUBookmarkedViewController" bundle:nil];
    [self.navigationController pushViewController:bookmarkController animated:YES];
}
@end
