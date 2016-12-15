//
//  UIColor+RXH.h
//  WhereMoneyGo
//
//  Created by Raymone on 16/6/2.
//  Copyright © 2016年 Raymone. All rights reserved.
//
#define HexColor(hexValue) [UIColor colorWithRGBHex:(hexValue)]
#import <UIKit/UIKit.h>

@interface UIColor (RXH)

- (UIColor *)initWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithRGBHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor*)colorWithRGBHex:(NSInteger)hexValue;

+ (UIColor *)colorWithRGBString:(NSString *)nsstring;
+ (UIColor *)colorWithRGBString:(NSString *)nsstring alpha:(CGFloat)alpha;

+ (UIColor *)colorWithPatternImageName:(NSString *)resourceName;

+ (UIColor *)randColorWithAlpha:(CGFloat)alpha;

/**
 *传一个0-255的Int类型的数字
 */
+ (UIColor *)colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha;
/**
 *传一个0-255的CGFloat类型的数字
 */
+ (UIColor *)colorWithFloatRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
@end
