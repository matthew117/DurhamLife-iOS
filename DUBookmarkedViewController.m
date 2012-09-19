//
//  DUBookmarkedViewController.m
//  Durham Life
//
//  Created by Matthew Bates on 29/08/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DUBookmarkedViewController.h"
#import "DUDataSingleton.h"
#import "SessionHandler.h"

@implementation DUBookmarkedViewController

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
    self.title = @"Bookmarked";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)enableFilters
{
    
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
        DUUser* user = [SessionHandler getUser];
        DUDataSingleton *dataProvider = [DUDataSingleton instance];
        backingArray = [dataProvider getUsersBookmarkedEvents:user];
        [self dataHasLoaded];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    [[NSBundle mainBundle] loadNibNamed:@"DUBookmarkTutorial" owner:self options:nil];

    return self.tutorialView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (backingArray.count < 1) return 416;
    else return 0;
}

@end