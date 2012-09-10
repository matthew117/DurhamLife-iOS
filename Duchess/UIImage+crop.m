//
//  UIImage+crop.m
//  Duchess
//
//  Created by Matthew Bates on 07/09/2012.
//
//

#import "UIImage+crop.h"

@implementation UIImage (crop)

- (UIImage *)crop:(CGRect)rect
{

    CGFloat cropRatio = rect.size.width / rect.size.height;
    if (cropRatio <= 1.0) cropRatio = rect.size.height / rect.size.width;
    CGFloat newImageWidth = cropRatio * self.size.height;
    
    CGRect cropRect = CGRectMake((self.size.width-newImageWidth)/2, 0, newImageWidth, self.size.height);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

@end
