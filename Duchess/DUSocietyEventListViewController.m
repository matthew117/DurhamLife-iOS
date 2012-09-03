//
//  DUSocietyEventListViewController.m
//  Duchess
//
//  Created by Matthew Bates on 31/08/2012.
//
//

#import "DUSocietyEventListViewController.h"
#import "DUDataSingleton.h"
#import "DUSocietyAboutViewController.h"
#import "SessionHandler.h"

@implementation DUSocietyEventListViewController
@synthesize subscribeButton;

@synthesize society;

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
    
    self.title = society.name;
    
    DUUser* user = [SessionHandler getUser];
    if ([user isSubscribedToSociety:society.name])
    {
        [subscribeButton setTitle:@"Unsubscribe" forState:UIControlStateNormal];
    }
    else
    {
        [subscribeButton setTitle:@"Subscribe" forState:UIControlStateNormal];
    }
}

- (void)viewDidUnload
{
    [self setSubscribeButton:nil];
    [super viewDidUnload];
    
    self.society = nil;
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
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getEventsBySociety:self.society.name];
        [self dataHasLoaded];
    }
}

- (void)dataHasLoaded
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}

- (IBAction)subcribeAction:(UIButton *)sender
{
    DUUser* user = [SessionHandler getUser];
    if ([user isSubscribedToSociety:society.name])
    {
        [subscribeButton setTitle:@"Subscribe" forState:UIControlStateNormal];
        [user unsubscribeFromSociety:society.name];
    }
    else
    {
        [subscribeButton setTitle:@"Unsubscribe" forState:UIControlStateNormal];
        [user subscribeToSociety:society.name];
    }
    [SessionHandler saveUser:user];
}

- (IBAction)aboutAction:(UIButton *)sender
{
    DUSocietyAboutViewController* aboutSocietyController = [[DUSocietyAboutViewController alloc] initWithNibName:@"DUSocietyAboutViewController" bundle:nil];
    aboutSocietyController.society = self.society;
    [self.navigationController pushViewController:aboutSocietyController animated:YES];
}

@end
