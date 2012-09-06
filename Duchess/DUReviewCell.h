//
//  DUReviewCell.h
//  Duchess
//
//  Created by App Dev on 06/09/2012.
//
//

#import <UIKit/UIKit.h>
#import "DURatingBar.h"

@interface DUReviewCell : UITableViewCell
+ (NSString*)reuseIdentifier;
@property (strong, nonatomic) IBOutlet UILabel *timestamp;
@property (strong, nonatomic) IBOutlet UILabel *comment;
@property (strong, nonatomic) IBOutlet DURatingBar *ratingBar;


@end
