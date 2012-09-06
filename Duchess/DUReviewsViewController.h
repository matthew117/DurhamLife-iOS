//
//  DUReviewsViewController.h
//  Duchess
//
//  Created by Jamie Bates on 05/09/2012.
//
//

#import <UIKit/UIKit.h>
#import "DUEvent.h"
#import "DUReviewCell.h"

@interface DUReviewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIActivityIndicatorView* downloadActivityIndicator;
    NSArray* backingArray;
}
    
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet DUReviewCell *reviewCell;
@property (strong, nonatomic) DUEvent* event;

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

@end
