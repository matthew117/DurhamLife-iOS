//
//  DUDashboardViewController.m
//  Duchess
//
//  Created by Matthew Bates on 20/08/2012.
//
//

#import "DUDashboardViewController.h"
#import "DUAboutViewController.h"
#import "RootViewController.h"

@interface DUDashboardViewController ()

@end

@implementation DUDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Durham Life";
    // Do any additional setup after loading the view from its nib.
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
    RootViewController* eventListController = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    [self.navigationController pushViewController:eventListController animated:YES];
}

- (IBAction)aboutButton:(UIButton *)sender
{
    DUAboutViewController *aboutView = [[DUAboutViewController alloc] init];
    [self presentModalViewController:aboutView animated:YES];
}
@end
