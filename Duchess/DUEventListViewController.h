//
//  DUEventListViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 26/08/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "DULoadingView.h"

@interface DUEventListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    IBOutlet UITableViewCell* customTableViewCell;
    DULoadingView* downloadActivityIndicator;
    NSArray* backingArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

- (void)enableFilters;
- (void)chooseFilter:(UIButton *)sender;

@end
