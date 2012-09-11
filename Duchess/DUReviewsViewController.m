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
#import "DUReviewEditor.h"

@implementation DUReviewsViewController

@synthesize tableView;
@synthesize event;
@synthesize reviewEditor;
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
    
    [[NSBundle mainBundle] loadNibNamed:@"DUReviewEditor" owner:self options:nil];
    
    self.tableView.tableHeaderView = reviewEditor;
    
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
    [self setReviewEditor:nil];
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
    
    DUReview *review = [[self getDataSet] objectAtIndex:indexPath.row];
    
    cell.timestamp.text = [review.timestamp description];
    cell.comment.text = review.comment;
    cell.ratingBar.rating = review.rating;
    
    CGSize maximumLabelSize = CGSizeMake(296,9999);
    
    CGSize expectedLabelSize = [review.comment sizeWithFont:cell.comment.font constrainedToSize:maximumLabelSize lineBreakMode:cell.comment.lineBreakMode];
    
    CGRect newFrame = cell.comment.frame;
    newFrame.size.height = expectedLabelSize.height;
    cell.comment.frame = newFrame;
    
    cell.comment.lineBreakMode = UILineBreakModeWordWrap;
    cell.comment.numberOfLines = 0;
    
    [cell.ratingBar setNeedsDisplay];
    [cell setUserInteractionEnabled:NO];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUReview *review = [backingArray objectAtIndex:indexPath.row];
    NSLog(@"%@", review.description);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUReview *review = [backingArray objectAtIndex:indexPath.row];
    
    if (review.comment == nil || [review.comment length] < 1) return 44;
    else
    {
        return ([review.comment sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(280, 9000) lineBreakMode:UILineBreakModeWordWrap].height) + 40;
    }
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
