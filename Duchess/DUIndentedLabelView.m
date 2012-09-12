//
//  DUIndentedLabelView.m
//  Durham Life
//
//  Created by Matthew Bates on 10/09/2012.
//
//

#import "DUIndentedLabelView.h"

@implementation DUIndentedLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect: CGRectInset(rect, 5, 0)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
