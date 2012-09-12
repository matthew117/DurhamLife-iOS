//
//  DUVisitorDashboardGridViewController.m
//  Durham Life
//
//  Created by Matthew Bates on 12/09/2012.
//
//

#import "DUVisitorDashboardGridViewController.h"

@interface DUVisitorDashboardGridViewController ()

@end

@implementation DUVisitorDashboardGridViewController
@synthesize eventsButton;
@synthesize calendarButton;
@synthesize bookmarkedButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setEventsButton:nil];
    [self setCalendarButton:nil];
    [self setBookmarkedButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)eventsAction:(UIButton *)sender {
}

- (IBAction)calendarAction:(UIButton *)sender {
}

- (IBAction)bookmarkedAction:(UIButton *)sender {
}
@end
