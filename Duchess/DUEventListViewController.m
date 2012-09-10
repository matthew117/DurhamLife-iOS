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
#import "Reachability.h"
#import "DUUser.h"
#import "SessionHandler.h"
#import "DURatingBar.h"

@implementation DUEventListViewController

@synthesize tableView;

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
    self.title = @"Events";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:self action:@selector(chooseFilter:)];

    Reachability *reach = [Reachability reachabilityWithHostName:@"www.dur.ac.uk"];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    downloadActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [downloadActivityIndicator setHidesWhenStopped:YES];
    [self.view addSubview: downloadActivityIndicator];
    downloadActivityIndicator.center = self.view.center;
    if (status == NotReachable)
    {
        [[[UIAlertView alloc] initWithTitle:@"Network Problem" message:@"Could not connect to the Internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else
    {
        [downloadActivityIndicator startAnimating];
        [self performSelectorInBackground:@selector(loadDataSet) withObject:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)chooseFilter:(UIButton *)sender
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:@"Choose Category"
        delegate:self cancelButtonTitle:(NSString *)@"Cancel" destructiveButtonTitle:nil
        otherButtonTitles:@"University", @"College", @"Music", @"Theatre",
                          @"Exhibitions", @"Sport", @"Conferences", @"Community", nil];
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)index
{
    if (index == sheet.cancelButtonIndex) return;
    NSString* category = [sheet buttonTitleAtIndex:index];
    
    @autoreleasepool
    {
        NSLog(@"Filter by: %@", category);
        
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getEventsByCategory:category];
        NSLog(@"New eventlist size: %d", backingArray.count);
        [self dataHasLoaded];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self getDataSet] == nil)
    {
        return 0;
    }
    else
    {
        return [[self getDataSet] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)parentTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    
    UITableViewCell *cell = [parentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DUCustomEventTableViewCell" owner:self options:nil];
        cell = customTableViewCell;
        customTableViewCell = nil;
    }
    
    DUEvent *event = [[self getDataSet] objectAtIndex:indexPath.row];
    
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
    
    DURatingBar *eventRatingBar;
    eventRatingBar = (DURatingBar *)[cell viewWithTag:5];
    [eventRatingBar setHidden:(event.averageReview < 1)];
    eventRatingBar.rating = event.averageReview;
    [eventRatingBar setNeedsDisplay];
    
    UILabel *eventReviewsLabel;
    eventReviewsLabel = (UILabel *)[cell viewWithTag:7];
    [eventReviewsLabel setHidden:(event.averageReview < 1)];
    eventReviewsLabel.text = [NSString stringWithFormat:@"based on %d %@", event.numberOfReviews,
                              event.numberOfReviews > 1 ? @"reviews" : @"review"];
    
    DUUser* user = [SessionHandler getUser];
    
    UIButton *bookmarkButton;
    bookmarkButton = (UIButton *)[cell viewWithTag:6];
    NSMutableDictionary* userBookmarks = user.bookmarkedEvents;
    
    [SessionHandler saveUser:user];
    
    if ([[userBookmarks objectForKey:[NSString stringWithFormat:@"%d",event.eventID]] boolValue])
    {
        [bookmarkButton setImage:[UIImage imageNamed:@"bookmark.png"] forState:UIControlStateNormal];
    }
    else
    {
        [bookmarkButton setImage:[UIImage imageNamed:@"clear_bookmark.png"] forState:UIControlStateNormal];
    }    
    [bookmarkButton addTarget:self action:@selector(bookmarkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)bookmarkButtonTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        DUEvent* event = [backingArray objectAtIndex:indexPath.row];
        UIButton *bookmarkButton = (UIButton*)[cell viewWithTag:6];
        
        DUUser* user = [SessionHandler getUser];
        NSMutableDictionary* userBookmarks = user.bookmarkedEvents;
        
        if ([[userBookmarks objectForKey:[NSString stringWithFormat:@"%d",event.eventID]] boolValue])
        {
            [bookmarkButton setImage:[UIImage imageNamed:@"clear_bookmark.png"] forState:UIControlStateNormal];
            [userBookmarks setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%d", event.eventID]];
            [SessionHandler saveUser:user];
        }
        else
        {
            [bookmarkButton setImage:[UIImage imageNamed:@"bookmark.png"] forState:UIControlStateNormal];
            [userBookmarks setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d", event.eventID]];
            [SessionHandler saveUser:user];
        }
    }
}

#pragma mark - UITableViewDelegate Implementation

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUEvent* event = [backingArray objectAtIndex:indexPath.row];
    if (event.averageReview < 1) return 110;
    else return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUEventDetailsViewController *detailViewController = [[DUEventDetailsViewController alloc] initWithNibName:@"DUEventDetailsView" bundle:nil];
    detailViewController.event = [backingArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
        backingArray = [dataProvider getAllEvents];
        [self dataHasLoaded];
    }
}

- (void)dataHasLoaded
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}

@end
