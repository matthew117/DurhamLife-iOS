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
#import "DUReviewEditor.h"

@interface DUReviewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UIActivityIndicatorView* downloadActivityIndicator;
    NSArray* backingArray;
}
    
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet DUReviewCell *reviewCell;
@property (strong, nonatomic) DUEvent* event;
@property (strong, nonatomic) IBOutlet DUReviewEditor *reviewEditor;

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

@end
