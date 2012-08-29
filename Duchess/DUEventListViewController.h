//
//  DUEventListViewController.h
//  Duchess
//
//  Created by Matthew Bates on 26/08/2012.
//
//

#import <UIKit/UIKit.h>

@interface DUEventListViewController : UITableViewController
{
    UITableViewCell* customTableViewCell;
    UIActivityIndicatorView* downloadActivityIndicator;
    NSArray* backingArray;
}

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

@end
