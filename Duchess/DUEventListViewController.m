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

@implementation DUEventListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.dur.ac.uk"];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    downloadActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
    if ([self getDataSet] == nil)
    {
        return 0;
    }
    else
    {
        return [[self getDataSet] count];
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
    
    UILabel *eventReviewsLabel;
    eventReviewsLabel = (UILabel *)[cell viewWithTag:5];
    NSMutableString *stars = [[NSMutableString alloc] init];
    for (int i = 0; i < event.averageReview; i++)
    {
        [stars appendString:@"*"];
    }
    eventReviewsLabel.text = [NSString stringWithFormat:@"%@", stars];
    
    UIButton *bookmarkButton;
    bookmarkButton = (UIButton *)[cell viewWithTag:6];
    bookmarkButton.selected = (event.eventID == 5);
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
        NSLog(@"eventBookmarked: %@", [(DUEvent*)[backingArray objectAtIndex:indexPath.row] name]);
        UIButton *bookmarkButton = (UIButton*)[cell viewWithTag:6];
        UILabel *label = (UILabel*)[cell viewWithTag:2];
        NSLog(@"eventLabl: %@", label.text);
        if ([bookmarkButton isSelected])
        {
            NSLog(@"BookmarkedUnselected");
            //bookmarkButton.imageView.image = [UIImage imageNamed:@"clear_bookmark.png"];
            //[bookmarkButton setBackgroundImage:[UIImage imageNamed:@"clear_bookmark.png"] forState:UIControlStateNormal];
            //bookmarkButton.selected = false;
            //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        }
        else
        {
            NSLog(@"BookmarkedSelected");
            //bookmarkButton.imageView.image = [UIImage imageNamed:@"bookmark.png"];
            //[bookmarkButton setBackgroundImage:[UIImage imageNamed:@"bookmark.png"] forState:UIControlStateSelected];
            //bookmarkButton.selected = true;
            //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        }
    }
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
    
    delegate.currentEvent = [backingArray objectAtIndex:indexPath.row];
    
    DUEventDetailsViewController *detailViewController = [[DUEventDetailsViewController alloc] initWithNibName:@"DUEventDetailsView" bundle:nil];
    
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
