//
//  DUReviewsViewController.m
//  Duchess
//
//  Created by Jamie Bates on 05/09/2012.
//
//

#import "DUReviewsViewController.h"
#import "Reachability.h"
#import "DUReview.h"
#import "DURatingBar.h"
#import "DUDataSingleton.h"

@implementation DUReviewsViewController

@synthesize tableView;
@synthesize event;
@synthesize reviewCell;

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
    
    [super viewDidLoad];
    self.title = @"Reviews";
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    reviewCell = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)parentTableView
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
    
    DUReviewCell *cell = (DUReviewCell *)[tableView dequeueReusableCellWithIdentifier:[DUReviewCell reuseIdentifier]];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DUReviewTableCell" owner:self options:nil];
        cell = reviewCell;
        reviewCell = nil;
    }
    /*
    static NSString *CellIdentifier = @"ReviewCell";
    
    UITableViewCell *cell = [parentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DUReviewTableCell" owner:self options:nil] lastObject];

        //[[NSBundle mainBundle] loadNibNamed:@"DUReviewTableCell" owner:self options:nil];
        //cell = reviewCell;
        reviewCell = nil;
    }
    */
    DUReview *review = [[self getDataSet] objectAtIndex:indexPath.row];
    /*
    UILabel *timepost = (UILabel*) [self.view viewWithTag:1];
    UILabel *reviewBody = (UILabel*) [self.view viewWithTag:2];
    DURatingBar *ratingBar = (DURatingBar*) [self.view viewWithTag:3];
    
    timepost.text = [review.timestamp description];
    reviewBody.text = review.comment;
    ratingBar.rating = review.rating;
     */
    
    cell.timestamp.text = [review.timestamp description];
    cell.comment.text = review.comment;
    cell.ratingBar.rating = review.rating;
    
    [cell.ratingBar setNeedsDisplay];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUReview *review = [backingArray objectAtIndex:indexPath.row];
    NSLog(review.description);
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
        backingArray = [dataProvider getReviews:event.eventID];
        [self dataHasLoaded];
    }
}

- (void)dataHasLoaded
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}


@end
