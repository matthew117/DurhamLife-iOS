//
//  DashboardBackground.m
//  Duchess
//
//  Created by Matthew Bates on 24/08/2012.
//
//

#import "DUDashboardBackground.h"

@implementation DUDashboardBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect insetFrame = CGRectInset(self.bounds, 5.0, 5.0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* darkGreyGradientColor = [UIColor colorWithRed: 0.3 green: 0.3 blue: 0.3 alpha: 1];
    UIColor* darkGreyGradientColor2 = [UIColor colorWithRed: 0.15 green: 0.15 blue: 0.15 alpha: 1];
    
    //// Gradient Declarations
    NSArray* darkGreyGradientColors = [NSArray arrayWithObjects:
                                       (id)darkGreyGradientColor.CGColor,
                                       (id)darkGreyGradientColor2.CGColor, nil];
    CGFloat darkGreyGradientLocations[] = {0, 1};
    CGGradientRef darkGreyGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)darkGreyGradientColors, darkGreyGradientLocations);
    
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: insetFrame cornerRadius: 10];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, darkGreyGradient, CGPointMake(0, 0), CGPointMake(0,self.frame.size.height), 0);
    CGContextRestoreGState(context);

    [[UIColor blackColor] setStroke];
    [roundedRectanglePath setLineWidth:1.0];
    [roundedRectanglePath stroke];
    
    CGGradientRelease(darkGreyGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
