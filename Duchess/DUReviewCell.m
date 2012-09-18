//
//  DUReviewCell.m
//  Durham Life
//
//  Created by Jamie Bates on 06/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DUReviewCell.h"

@implementation DUReviewCell

@synthesize timestamp;
@synthesize comment;
@synthesize ratingBar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier
{
    return @"ReviewCell";
}


@end
