//
//  UIImage+GnomeKit.m
//  GnomeKit
//
//  Created by Smith, Brandon on 5/17/13.
//  Copyright (c) 2013 Smith, Brandon. All rights reserved.
//

#import "UIImage+GnomeKit.h"

@implementation UIImage (GnomeKit)

CGFloat EdgeInset(CGFloat radius)
{
    return radius * 2.0f + 1.0f;
}

+ (instancetype)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius
{
    CGFloat edgeSize = EdgeInset(radius);
    CGRect rect = CGRectMake(0.0f, 0.0f, edgeSize, edgeSize);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    path.lineWidth = 0.0f;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    [color setFill];
    [path fill];
    [path stroke];
    [path addClip];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
}

+ (instancetype)circleImageWithColor:(UIColor *)color
                              radius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, radius * 2.0f, radius * 2.0f);
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    
    [color setFill];
    [color setStroke];
    [circle addClip];
    [circle fill];
    [circle stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageWithMinimumSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    CGFloat h,w;
    h = size.height / 2.0f;
    w = size.width / 2.0f;
    UIEdgeInsets insets = UIEdgeInsetsMake(h, w, h, w);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:insets];
}

@end
