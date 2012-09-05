//
//  DUReviewsViewController.h
//  Duchess
//
//  Created by Jamie Bates on 05/09/2012.
//
//

#import <UIKit/UIKit.h>
#import "DUEvent.h"

@interface DUReviewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIActivityIndicatorView* downloadActivityIndicator;
    NSArray* backingArray;
    IBOutlet UITableViewCell *reviewCell;
}
    
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) DUEvent* event;

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

@end
