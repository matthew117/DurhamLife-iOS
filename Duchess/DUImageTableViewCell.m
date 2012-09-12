//
//  DUImageTableViewCell.m
//  Durham Life
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
    
    self.textLabel.frame = CGRectInset(self.contentView.bounds, 5, 5);
    self.textLabel.textAlignment = UITextAlignmentCenter;
    
    self.imageView.frame = CGRectInset(self.imageView.bounds, 5, 5);
    self.imageView.frame = CGRectMake((self.contentView.bounds.size.width/2) - (self.imageView.bounds.size.width/2), 5, self.imageView.frame.size.width, self.imageView.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
