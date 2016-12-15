//
//  UIColor+RXH.m
//  WhereMoneyGo
//
//  Created by Raymone on 16/6/2.
//  Copyright © 2016年 Raymone. All rights reserved.
//

#import "UIColor+RXH.h"

@implementation UIColor (RXH)

- (UIColor *)initWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
    return [self initWithRed:((hexValue & 0xFF0000) >> 16)/255.0f
                       green:((hexValue & 0xFF00) >> 8)/255.0f
                        blue:(hexValue & 0xFF)/255.0f
                       alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hexValue & 0xFF0000) >> 16)/255.0f
                           green:((hexValue & 0xFF00) >> 8)/255.0f
                            blue:(hexValue & 0xFF)/255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(NSInteger)hexValue {
    return [UIColor colorWithRGBHex:hexValue alpha:1.0f];
}

+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithFloatRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:alpha];
}


+ (UIColor *)colorWithRGBString:(NSString *)nsstring {
    NSUInteger length = nsstring.length-1;
    //	if (length != 3 && length != 6 ) return [UIColor clearColor];
    if (length != 6 ) return [UIColor clearColor];
    if ([nsstring characterAtIndex:0] != '#') return [UIColor clearColor];
    int color;
    sscanf([nsstring UTF8String], "#%x", &color);
    return [UIColor colorWithRGBHex:color];
}

+ (UIColor *)colorWithRGBString:(NSString *)nsstring alpha:(CGFloat)alpha {
    NSUInteger length = nsstring.length-1;
    //	if (length != 3 && length != 6 ) return [UIColor clearColor];
    if (length != 6 ) return [UIColor clearColor];
    if ([nsstring characterAtIndex:0] != '#') return [UIColor clearColor];
    int color;
    sscanf([nsstring UTF8String], "#%x", &color);
    return [UIColor colorWithRGBHex:color alpha:alpha];
}

+ (UIColor *)colorWithPatternImageName:(NSString *)resourceName {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:resourceName]];
}

+ (UIColor *)randColorWithAlpha:(CGFloat)alpha {
    BOOL fakeRandom = NO;
    if (fakeRandom) {
        return [UIColor colorWithRed:rand()%255/255.f green:rand()%255/255.f blue:rand()%255/255.f alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:alpha];
    }
}


@end
