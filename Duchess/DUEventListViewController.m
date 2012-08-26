//
//  DUEventListViewController.m
//  Duchess
//
//  Created by Matthew Bates on 26/08/2012.
//
//

#import "DUEventListViewController.h"
#import "DUDataSingleton.h"
#import "DUEvent.h"
#import "DUAppDelegate.h"
#import "DUEventDetailsViewController.h"
#import "DUNetworkedDataProvider.h"

@interface DUEventListViewController ()

@end

@implementation DUEventListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self){}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DUDataSingleton *dataProvider = [DUDataSingleton instance];
    NSMutableArray *eventList = dataProvider.eventList;
    
    if (eventList == nil)
    {
        return 0;
    }
    else
    {
        return [eventList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DUCustomEventTableViewCell" owner:self options:nil];
        cell = customTableViewCell;
        customTableViewCell = nil;
    }
    
    DUDataSingleton *dataProvider = [DUDataSingleton instance];
    NSMutableArray *eventList = dataProvider.eventList;
    DUEvent *event = [eventList objectAtIndex:indexPath.row];
    
    UILabel *eventNameLabel;
    eventNameLabel = (UILabel *)[cell viewWithTag:1];
    eventNameLabel.text = event.name;
    
    UILabel *eventAddressLabel;
    eventAddressLabel = (UILabel *)[cell viewWithTag:2];
    eventAddressLabel.text = event.location.address1;
    
    UILabel *eventDateLabel;
    eventDateLabel = (UILabel *)[cell viewWithTag:3];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d MMMM"];
    
    NSString *eventStartDateStr = [formatter stringFromDate:event.startDate];
    NSString *eventEndDateStr = [formatter stringFromDate:event.endDate];
    eventDateLabel.text = [NSString stringWithFormat:@"%@ until %@", eventStartDateStr, eventEndDateStr];
    
    UILabel *eventDescriptionLabel;
    eventDescriptionLabel = (UILabel *)[cell viewWithTag:4];
    eventDescriptionLabel.text = event.descriptionHeader;
    
    UILabel *eventReviewsLabel;
    eventReviewsLabel = (UILabel *)[cell viewWithTag:5];
    NSMutableString *stars = [[NSMutableString alloc] init];
    for (int i = 0; i < event.averageReview; i++)
    {
        [stars appendString:@"*"];
    }
    eventReviewsLabel.text = [NSString stringWithFormat:@"%@", stars];
    
    return cell;
}

#pragma mark - UITableViewDelegate Implementation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight;
    cellHeight = 120.0f;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.currentEvent = indexPath.row;
    
    DUEventDetailsViewController *detailViewController = [[DUEventDetailsViewController alloc] initWithNibName:@"DUEventDetailsTabRoot" bundle:nil];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Background Thread

- (void)loadEventsOnBackgroundThread
{
    @autoreleasepool
    {
        DUNetworkedDataProvider *networkDataAccess = [[DUNetworkedDataProvider alloc] init];
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        dataProvider.eventList = [[NSMutableArray alloc] init];
        NSMutableArray *eventList = dataProvider.eventList;
        
        [networkDataAccess downloadAndParseEvents:eventList fromURL:@"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/events.php" target:self selector:@selector(gotLoadedEvents)];
    }
}

- (void)gotLoadedEvents
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}

@end
