//
//  DURatingBar.m
//  Durham Life
//
//  Created by Matthew Bates on 05/09/2012.
//  Copyright (C) 2012 Durham University. All Rights Reserved.
//

#import "DURatingBar.h"

@implementation DURatingBar

@synthesize rating;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        rating = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* purple = [UIColor colorWithRed: 0.51 green: 0.22 blue: 0.51 alpha: 1];
    UIColor* light_purple = [UIColor colorWithRed: 0.8 green: 0.62 blue: 0.83 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                                (id)light_purple.CGColor,
                                (id)purple.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    int numOfFullStars = rating / 2;
    
    for (int i = 0; i < numOfFullStars; i++)
    {
        CGFloat width = self.frame.size.width/5;
        CGFloat height = self.frame.size.height;
        CGFloat x = i*width;
        
        //// Star Drawing
        UIBezierPath* starPath = [UIBezierPath bezierPath];
        [starPath moveToPoint: CGPointMake(x + width/2, 0)];
        [starPath addLineToPoint: CGPointMake(x + width/3, height*0.3)];
        [starPath addLineToPoint: CGPointMake(x + 0, height*0.37)];
        [starPath addLineToPoint: CGPointMake(x + 0.22*width, height*0.6)];
        [starPath addLineToPoint: CGPointMake(x + 0.18*width, height*0.95)];
        [starPath addLineToPoint: CGPointMake(x + width/2, height*0.80)];
        [starPath addLineToPoint: CGPointMake(x + 0.82*width, height*0.95)];
        [starPath addLineToPoint: CGPointMake(x + 0.78*width, height*0.6)];
        [starPath addLineToPoint: CGPointMake(x + width, height*0.37)];
        [starPath addLineToPoint: CGPointMake(x + width*(2.0/3.0), height*0.3)];
        [starPath closePath];
        CGContextSaveGState(context);
        [starPath addClip];
        CGContextDrawLinearGradient(context, gradient, CGPointMake(width/2, 0), CGPointMake(width/2, height), 0);
        CGContextRestoreGState(context);
    }
    
    for (int i = numOfFullStars; i < 5; i++)
    {
        CGFloat width = self.frame.size.width/5;
        CGFloat height = self.frame.size.height;
        CGFloat x = i*width;
        
        //// Star Drawing
        UIBezierPath* starPath = [UIBezierPath bezierPath];
        [starPath moveToPoint: CGPointMake(x + width/2, 0)];
        [starPath addLineToPoint: CGPointMake(x + width/3, height*0.3)];
        [starPath addLineToPoint: CGPointMake(x + 0, height*0.37)];
        [starPath addLineToPoint: CGPointMake(x + 0.22*width, height*0.6)];
        [starPath addLineToPoint: CGPointMake(x + 0.18*width, height*0.95)];
        [starPath addLineToPoint: CGPointMake(x + width/2, height*0.80)];
        [starPath addLineToPoint: CGPointMake(x + 0.82*width, height*0.95)];
        [starPath addLineToPoint: CGPointMake(x + 0.78*width, height*0.6)];
        [starPath addLineToPoint: CGPointMake(x + width, height*0.37)];
        [starPath addLineToPoint: CGPointMake(x + width*(2.0/3.0), height*0.3)];
        [starPath closePath];
        CGContextSaveGState(context);
        [starPath addClip];
        [[UIColor lightGrayColor] setFill];
        [starPath fill];
        CGContextRestoreGState(context);

    }
    
    if (rating % 2 != 0)
    {
        CGFloat width = self.frame.size.width/5;
        CGFloat height = self.frame.size.height;
        CGFloat x = (rating/2)*width;
        
        //// Star Drawing
        UIBezierPath* starPath = [UIBezierPath bezierPath];
        [starPath moveToPoint: CGPointMake(x + width/2, 0)];
        [starPath addLineToPoint: CGPointMake(x + width/3, height*0.3)];
        [starPath addLineToPoint: CGPointMake(x + 0, height*0.37)];
        [starPath addLineToPoint: CGPointMake(x + 0.22*width, height*0.6)];
        [starPath addLineToPoint: CGPointMake(x + 0.18*width, height*0.95)];
        [starPath addLineToPoint: CGPointMake(x + width/2, height*0.80)];
        [starPath closePath];
        CGContextSaveGState(context);
        [starPath addClip];
        CGContextDrawLinearGradient(context, gradient, CGPointMake(width/2, 0), CGPointMake(width/2, height), 0);
        CGContextRestoreGState(context);

    }
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint point = [(UITouch*)[touches anyObject] locationInView:self];
	rating = (int) (point.x / (self.frame.size.width/10)) + 1;
    NSLog(@"Rating: %d", rating);
    [self setNeedsDisplay];
}

@end
