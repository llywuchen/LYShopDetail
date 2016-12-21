//
//  UIColor+BS.m
//
//  Created by  on 12-1-5.
//  Copyright (c) 2012年  All rights reserved.
//

#import "UIColor+GGColor.h"

@implementation UIColor (GGColor)

+ (UIColor*)colorWithARGB:(NSUInteger)argb
{
    CGFloat alpha = (argb > 0xFFFFFF) ? (((argb>>24)&0xFF)/255.0f) : 1.0f;
    return [UIColor colorWithRGB:argb alpha:alpha];
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb;
{
    return [UIColor colorWithRGB:rgb alpha:1.0f];
}

+ (UIColor*)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha
{
    NSUInteger red = (rgb>>16)&0xFF;
    NSUInteger green = (rgb>>8)&0xFF;
    NSUInteger blue = rgb&0xFF;
    return RGBA(red, green, blue, alpha);
}

+ (UIColor*)colorWithString:(NSString *)strColor
{
    NSArray* colorValueArr = [strColor componentsSeparatedByString:@"|"];
    if (colorValueArr.count < 3 || colorValueArr.count > 4) {
        return nil;
    }
    
    NSUInteger red = [[colorValueArr objectAtIndex:0] integerValue];
    NSUInteger green = [[colorValueArr objectAtIndex:1] integerValue];
    NSUInteger blue = [[colorValueArr objectAtIndex:2] integerValue];
    CGFloat alpha = 1.0f;
    if (colorValueArr.count == 4) {
        alpha = [[colorValueArr objectAtIndex:3] floatValue];
    }
    return RGBA(red, green, blue, alpha);
}

@end
