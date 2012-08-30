//
//  DUSocietyListViewController.m
//  Duchess
//
//  Created by Matthew Bates on 28/08/2012.
//
//

#import "DUSocietyListViewController.h"
#import "DUDataSingleton.h"
#import "DUSociety.h"
#import "Reachability.h"

@interface DUSocietyListViewController ()

@end

@implementation DUSocietyListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Societies";
    
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
    backingArray = nil;
    downloadActivityIndicator = nil;
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
    return [[self getDataSet] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DUSociety* society = [[self getDataSet] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = society.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DUSociety* society = [[self getDataSet] objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:society.name message:society.constitution
                          delegate:nil cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        backingArray = [dataProvider getSocieties];
        [self dataHasLoaded];
    }
}

- (void)dataHasLoaded
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}


@end
