//
//  DUBookmarkedViewController.m
//  Duchess
//
//  Created by Matthew Bates on 29/08/2012.
//
//

#import "DUBookmarkedViewController.h"
#import "DUDataSingleton.h"

@implementation DUBookmarkedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _backingArray = nil;
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

#pragma mark - Background Thread

- (void)loadEventsOnBackgroundThread
{
    @autoreleasepool
    { /*
        DUNetworkedDataProvider *networkDataAccess = [[DUNetworkedDataProvider alloc] init];
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        dataProvider.eventList = [[NSMutableArray alloc] init];
        NSMutableArray *eventList = dataProvider.eventList;
        
        [networkDataAccess downloadAndParseEvents:eventList fromURL:@"http://www.dur.ac.uk/cs.seg01/duchess/api/v1/events.php" target:self selector:@selector(gotLoadedEvents)];
    */
    }
}

- (void)gotLoadedEvents
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}

@end