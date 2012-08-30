//
//  DUSocietyListViewController.h
//  Duchess
//
//  Created by Matthew Bates on 28/08/2012.
//
//

#import <UIKit/UIKit.h>
#import "DUDataSingleton.h"
#import "DUSociety.h"

@interface DUSocietyListViewController : UITableViewController
{
    NSArray* backingArray;
    UIActivityIndicatorView* downloadActivityIndicator;
}
@end
