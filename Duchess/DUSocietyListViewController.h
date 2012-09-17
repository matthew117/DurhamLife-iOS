//
//  DUSocietyListViewController.h
//  Durham Life
//
//  Created by Matthew Bates on 28/08/2012.
//
//

#import <UIKit/UIKit.h>
#import "DUDataSingleton.h"
#import "DUSociety.h"
#import "DULoadingView.h"

@interface DUSocietyListViewController : UITableViewController
{
    NSArray* backingArray;
    DULoadingView* downloadActivityIndicator;
}

- (NSArray*)getDataSet;
- (void)loadDataSet;
- (void)dataHasLoaded;

@end
