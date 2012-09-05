//
//  DUReviewsViewController.h
//  Duchess
//
//  Created by Jamie Bates on 05/09/2012.
//
//

#import <UIKit/UIKit.h>

@interface DUReviewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
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
