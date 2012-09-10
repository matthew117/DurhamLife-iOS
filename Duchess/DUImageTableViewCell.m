//
//  DUImageTableViewCell.m
//  Duchess
//
//  Created by Matthew Bates on 10/09/2012.
//
//

#import "DUImageTableViewCell.h"

@implementation DUImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectInset(self.contentView.bounds, 5, 5);
    self.textLabel.frame = CGRectInset(self.contentView.bounds, 5, 5);
    self.textLabel.textAlignment = UITextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
