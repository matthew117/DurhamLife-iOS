//
//  MySocietiesListViewController.m
//  Durham Life
//
//  Created by Matthew Bates on 30/08/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    [[NSBundle mainBundle] loadNibNamed:@"DUSocietyTutorial" owner:self options:nil];
    
    return self.tutorialView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (backingArray.count < 1) return 416;
    else return 0;
}

@end
