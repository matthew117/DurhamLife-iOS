//
//  DUDashboardViewController.m
//  Durham Life
//
//  Created by Matthew Bates on 20/08/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DUDashboardViewController.h"
#import "DUAboutViewController.h"
#import "DUCollegeEventsViewController.h"
#import "DUSocietyListViewController.h"
#import "SessionHandler.h"
#import "DUEventListViewController.h"
#import "DUSettingsViewController.h"
#import "DUBookmarkedViewController.h"
#import "DUMySocietiesListViewController.h"
#import "DUCalendarViewController.h"
#import "UIImage+crop.h"

@implementation DUDashboardViewController

@synthesize adText;
@synthesize adImage;
@synthesize visitorBoard;
@synthesize normalBoard;
@synthesize buttonGrid;

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(settingsButton:)];
    
    UIButton* aboutButtonItem = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [aboutButtonItem addTarget:self action:@selector(aboutButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aboutButtonItem];

    
    [SessionHandler setDefaults];
    if ([SessionHandler appOpenedForFirstTime])
    {
        NSLog(@"This is a first time run.");
        NSLog(@"%@",[SessionHandler userDefaultsToString]);
    }
    
    // ==================================================================
    // Set first time use to NO
    // ==================================================================
    
    [self performSelectorInBackground:@selector(downloadAndDisplayADImage) withObject:nil];
}


- (void)viewDidUnload
{
    [self setAdText:nil];
    [self setAdImage:nil];

    [self setButtonGrid:nil];
    [self setVisitorBoard:nil];
    [self setNormalBoard:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    DUUser *user = [SessionHandler getUser];
    if (user.userAffiliation == VISITOR)
    {
        NSLog(@"VISITOR");
        [[NSBundle mainBundle] loadNibNamed:@"DUVisitorDashboardGrid" owner:self options:nil];
        [[buttonGrid subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [buttonGrid addSubview:visitorBoard];
    }
    else
    {
        NSLog(@"NOT VISITOR");
        [[NSBundle mainBundle] loadNibNamed:@"DUNormalDashboardGrid" owner:self options:nil];
        [[buttonGrid subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
        [buttonGrid addSubview:normalBoard];
    }
    NSLog(@"ViewWillAppear");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)eventsAction:(UIButton *)sender
{
    DUEventListViewController* eventListController = [[DUEventListViewController alloc] initWithNibName:@"DUEventListView" bundle:nil];
    [self.navigationController pushViewController:eventListController animated:YES];
}

- (void)aboutButton:(UIButton *)sender
{
    DUAboutViewController *aboutView = [[DUAboutViewController alloc] init];
    [self presentModalViewController:aboutView animated:YES];
}

- (IBAction)adAction:(id *)sender
{
    NSURL *url = [NSURL URLWithString:adLink];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)collegeAction:(UIButton *)sender
{
    DUCollegeEventsViewController* collegeListController = [[DUCollegeEventsViewController alloc] initWithNibName:@"DUCollegeEventsViewController" bundle:nil];
    [self.navigationController pushViewController:collegeListController animated:YES];

}

- (IBAction)calendarAction:(UIButton *)sender
{
    DUCalendarViewController* calendarController = [[DUCalendarViewController alloc] initWithNibName:@"DUCalendarViewController" bundle:nil];
    [self.navigationController pushViewController:calendarController animated:YES];
    
}

- (IBAction)societiesAction:(UIButton *)sender
{
    DUSocietyListViewController* societyListController = [[DUSocietyListViewController alloc] initWithNibName:@"DUSocietyListViewController" bundle:nil];
    [self.navigationController pushViewController:societyListController animated:YES];
}

- (void)settingsButton:(UIButton *)sender
{
    DUSettingsViewController* settingsController = [[DUSettingsViewController alloc] initWithNibName:@"DUSettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsController animated:YES];
}

- (IBAction)bookmarkedAction:(UIButton *)sender
{
    DUBookmarkedViewController* bookmarkController = [[DUBookmarkedViewController alloc] initWithNibName:@"DUBookmarkedViewController" bundle:nil];
    [self.navigationController pushViewController:bookmarkController animated:YES];
}

- (IBAction)mySocietiesAction:(UIButton *)sender
{
    DUMySocietiesListViewController* mySocietiesController = [[DUMySocietiesListViewController alloc] initWithNibName:@"DUMySocietiesListViewController" bundle:nil];
    [self.navigationController pushViewController:mySocietiesController animated:YES];
}

- (void)downloadAndDisplayADImage
{
	NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/features.php"]];
    NSData *loadedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
	if (error == nil)
	{
		NSLog(@"Loaded page from: %@", @"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/features.php");
		
		NSString *downloadedString = [[NSString alloc] initWithData:loadedData encoding:NSUTF8StringEncoding];
		NSArray *adSpec = [downloadedString componentsSeparatedByString: @"\n"];
		adText.titleLabel.text = [adSpec objectAtIndex:1];
        [adText setNeedsDisplay];
        [adText addTarget:self action:@selector(adAction:) forControlEvents:UIControlEventTouchUpInside];
		adLink = [adSpec objectAtIndex:3];
		NSURL *url = [NSURL URLWithString: [adSpec objectAtIndex:2]];
		adImage.image = [[UIImage imageWithData: [NSData dataWithContentsOfURL:url]] crop:adImage.frame];
        [UIView animateWithDuration:1.5f animations:^{[adImage setAlpha:1];}];
        [UIView animateWithDuration:1.5f animations:^{[adText setAlpha:1];}];
	}
	else
	{
		NSLog(@"ERROR: %@", error);
	}
}

@end
