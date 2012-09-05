//
//  DUGradientBackground.m
//  Duchess
//
//  Created by Matthew Bates on 05/09/2012.
//
//

#import "DUGradientBackground.h"

@implementation DUGradientBackground

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
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* purple = [UIColor colorWithRed: 0.51 green: 0.22 blue: 0.51 alpha: 1];
    UIColor* light_purple = [UIColor colorWithRed: 0.8 green: 0.62 blue: 0.83 alpha: 1];
    
    NSArray* gradientColors = [NSArray arrayWithObjects:
                                (id)light_purple.CGColor,
                                (id)purple.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);    
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
