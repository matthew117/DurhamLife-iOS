//
//  DUReviewCell.h
//  Durham Life
//
//  Created by Jamie Bates on 06/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import <UIKit/UIKit.h>
#import "DURatingBar.h"

@interface DUReviewCell : UITableViewCell
+ (NSString*)reuseIdentifier;
@property (strong, nonatomic) IBOutlet UILabel *timestamp;
@property (strong, nonatomic) IBOutlet UILabel *comment;
@property (strong, nonatomic) IBOutlet DURatingBar *ratingBar;


@end
