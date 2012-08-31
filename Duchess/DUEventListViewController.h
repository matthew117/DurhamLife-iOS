//
//  DUEventListViewController.h
//  Duchess
//
//  Created by Matthew Bates on 26/08/2012.
//
//

#import <UIKit/UIKit.h>

@interface DUEventListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableViewCell* customTableViewCell;
    UIActivityIndicatorView* downloadActivityIndicator;
    NSArray* backingArray;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

@end
