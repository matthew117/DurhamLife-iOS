//
//  DUCollegeEventsViewController.m
//  Duchess
//
//  Created by Matthew Bates on 26/08/2012.
//
//

#import "DUCollegeEventsViewController.h"
#import "DUDataSingleton.h"
#import "DUUser.h"
#import "SessionHandler.h"
#import "DUAppDelegate.h"
#import "DUEvent.h"
#import "DUEventDetailsViewController.h"
#import "DUNetworkedDataProvider.h"
#import "Reachability.h"

@implementation DUCollegeEventsViewController

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
    self.title = @"College Events";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Customize Data Set

- (NSArray*)getDataSet
{
    return backingArray;
}

#pragma mark - Background Thread

- (void)loadDataSet
{
    @autoreleasepool
    {
        DUUser* user = [SessionHandler getUser];
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getEventsByCollege:[user getPrimaryCollege]];
        [self dataHasLoaded];
    }
}

- (void)dataHasLoaded
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}

@end