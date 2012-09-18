//
//  DUIndentedLabelView.m
//  Durham Life
//
//  Created by Matthew Bates on 10/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DUIndentedLabelView.h"

@implementation DUIndentedLabelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor colorWithWhite:0 alpha:0.5] setFill];
    [rectPath fill];
    
    [[UIColor whiteColor] setFill];
    [self.titleLabel.text drawInRect:CGRectInset(rect, 5, 3) withFont:[UIFont systemFontOfSize:17.0] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
    
    UIImage *navigationIndicator = [UIImage imageNamed:@"ad_navigation.png"];
    [navigationIndicator drawAtPoint:CGPointMake(self.bounds.size.width - navigationIndicator.size.width, 0)];
}

@end
