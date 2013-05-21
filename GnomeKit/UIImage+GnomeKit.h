//
//  UIImage+GnomeKit.h
//  GnomeKit
//
//  Created by Smith, Brandon on 5/17/13.
//  Copyright (c) 2013 Smith, Brandon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GnomeKit)

+ (instancetype)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius;

+ (instancetype)circleImageWithColor:(UIColor *)color radius:(CGFloat)radius;

- (UIImage *)imageWithMinimumSize:(CGSize)size;

@end
