//
//  MySocietiesListViewController.m
//  Duchess
//
//  Created by Matthew Bates on 30/08/2012.
//
//

#import "DUMySocietiesListViewController.h"
#import "SessionHandler.h"

@implementation DUMySocietiesListViewController

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
    self.title = @"My Societies";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
        NSArray* societyList = [dataProvider getSocieties];
        NSMutableArray* tempList = [NSMutableArray new];
        for (DUSociety* society in societyList)
        {
            if ([user isSubscribedToSociety:society.name])
            {
                [tempList addObject:society];
            }
        }
        backingArray = [NSArray arrayWithArray:tempList];
        [self dataHasLoaded];
    }
}

- (void)dataHasLoaded
{
    [downloadActivityIndicator stopAnimating];
    [self.tableView reloadData];
}

@end
