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
    reviewCell = nil;
    [super viewDidUnload];
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
    static NSString *CellIdentifier = @"ReviewCell";
    
    UITableViewCell *cell = [parentTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DUReviewTableCell" owner:self options:nil];
        cell = reviewCell;
        reviewCell = nil;
    }
    
    DUReview *review = [[self getDataSet] objectAtIndex:indexPath.row];
    
    UILabel *timepost = (UILabel*) [self.view viewWithTag:1];
    UILabel *reviewBody = (UILabel*) [self.view viewWithTag:2];
    DURatingBar *ratingBar = (DURatingBar*) [self.view viewWithTag:3];
    
    timepost.text = [review.timestamp description];
    reviewBody.text = review.comment;
    ratingBar.rating = review.rating;
    [ratingBar setNeedsDisplay];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
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
