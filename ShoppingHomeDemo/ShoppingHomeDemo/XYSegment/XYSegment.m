//
//  XYSegment.m
//  SugemtTest
//
//  Created by Raymone on 16/4/12.
//  Copyright © 2016年 Raymone. All rights reserved.
//

#import "XYSegment.h"
#import "UIColor+RXH.h"

#define XYSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define XYStyleHeight 31
#define XYTextStyleWidth 48

@interface XYSegment(){
    XYSSegmentDidSelectedBlock _sblock;
}


@property(nonatomic, assign) CGFloat buttonStyleHeight;

@property(nonatomic, strong) UIColor *xy_itemStyleSelectedColor;

@property(nonatomic, strong) UIColor *xy_itemSelectedColor;

@property(nonatomic, strong) NSMutableArray *buttonArray;

@property(nonatomic, strong) NSArray *allItems;

@property(nonatomic, strong) UIView *buttonStyle;

@property(nonatomic, assign) CGFloat buttonStyleY;

@property(nonatomic, assign) CGFloat buttonLineHeight;

@property(nonatomic, assign) BOOL buttonStyleMasksToBounds;

@property(nonatomic, assign) CGFloat buttonStyleCornerRadius;

@property(nonatomic, assign) CGFloat leftMargin;

@property(nonatomic, assign) CGFloat buttonStyleTopMargin;

@property(nonatomic, strong) UIColor *xy_itemDefaultColor;

@property(nonatomic, strong) UIButton *selectedButton;

@property(nonatomic, assign) CGFloat buttonMargin;

@property(nonatomic, strong) UIFont *textFont;

@property(nonatomic, strong) UIImageView *buttonStyleImageView;

@property(nonatomic, assign) XYSSegmentStyle segmentStyle;

@property(nonatomic, assign) CGFloat maxOriginX;

@property(nonatomic, readwrite) NSInteger selectIndex;

@property(nonatomic, assign) CGFloat SelectButtonAlpha;

@property(nonatomic, strong) UIColor *backGroundColor;

@property(nonatomic, assign) CGFloat maxContentX;

@end

@implementation XYSegment

+ (XYSegment *)xy_segmentWithFrame:(CGRect)frame style:(XYSSegmentStyle)style {
    return [[XYSegment alloc] initWithFrame:frame style:style];
}

#pragma mark - Life Cycle
- (id)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(XYSSegmentStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = *(&(style));
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.scrollsToTop = NO;
    self.buttonStyle = [[UIView alloc] init];
    self.buttonStyleImageView = [[UIImageView alloc]initWithFrame:self.buttonStyle.bounds];
    [self.buttonStyle addSubview:self.buttonStyleImageView];
    [self buttonStyleFromSegmentStyle];
    self.buttonArray = [NSMutableArray array];
    self.allItems = [NSMutableArray array];
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.buttonStyle.layer.masksToBounds = self.buttonStyleMasksToBounds;
    self.buttonStyle.layer.cornerRadius = self.buttonStyleCornerRadius;
    [self addSubview:self.buttonStyle];
}

-(void)settingDefaultColor:(UIColor *)color selectedColor:(UIColor *)selectedColor SelectedButtonImage:(UIImage *)image textFont:(UIFont *)font buttonMargin:(CGFloat)margin{
    _buttonStyleImageView.image = image;
    _xy_itemDefaultColor = color;
    _xy_itemSelectedColor = selectedColor;
    _buttonMargin = margin;
    _textFont = font;
}

-(UIImage *)newBackgroundImg:(NSString *)oldImage{
    
    UIImage *oldImg = [UIImage imageNamed:oldImage];
    CGFloat w = oldImg.size.width * 0.5;
    CGFloat h = oldImg.size.height *0.5;
    UIImage *newImg = [oldImg resizableImageWithCapInsets:UIEdgeInsetsMake(h,w,h,w) resizingMode:UIImageResizingModeStretch];
    return newImg;
}

- (void)buttonStyleFromSegmentStyle {
    _buttonStyleHeight = XYStyleHeight;
    _SelectButtonAlpha = 1.0;
    _buttonStyleTopMargin = (self.frame.size.height - XYStyleHeight)*0.5;
    _buttonSelectedTopStyle = ButtonSelectedStyleCenter;
    switch (self.segmentStyle) {
        case XYSegmentStyleT01:
            _backGroundColor =  [UIColor whiteColor];
            [self settingDefaultColor:[UIColor colorWithRGBHex:0x676974]
                        selectedColor:[UIColor colorWithRed:240/255 green:100/255 blue:100/255 alpha:1.0]
                  SelectedButtonImage:[self newBackgroundImg:@"T03"]
                             textFont:[UIFont systemFontOfSize:14]
                         buttonMargin:0.0];
            break;
        case XYSegmentStyleT02:
            [self settingDefaultColor:[UIColor colorWithRGBHex:0xFFFFFF alpha:0.5]
                        selectedColor:[UIColor colorWithRGBHex:0xFFFFFF]
                  SelectedButtonImage:[self newBackgroundImg:@"T02"]
                             textFont:[UIFont systemFontOfSize:14]
                         buttonMargin:0.0];
            break;
            
        case XYSegmentStyleText:
            _backGroundColor =  [UIColor colorWithRGBHex:0xF9F9F9];;
            [self settingDefaultColor:[UIColor colorWithRGBHex:0x848694]
                        selectedColor:[UIColor colorWithRGBHex:0x009CFF]
                  SelectedButtonImage:nil
                             textFont:[UIFont systemFontOfSize:15]
                         buttonMargin:10.0];
            _SelectButtonAlpha = 0.5;
            break;
        default:
            break;
    }
    
}

- (CGFloat)textWidthWithFontSize:(CGFloat)fontSize Text:(NSString *)text {
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attr
                                     context:nil];
    return size.size.width;
}

-(CGFloat)lengthForItem:(NSString *)title{
    CGFloat length = title.length == 2 ? 60 : title.length == 3 ? 80 : 90;
//    if (self.segmentStyle == XYSegmentStyleText) {
//        return XYTextStyleWidth;
//    }
    return length;
}

-(CGFloat)totalLengthForTitleList:(NSArray *)titleList{
    CGFloat totalLength = 0;
    for (int i = 0; i < titleList.count; i ++) {
        totalLength += [self lengthForItem:titleList[i]];
    }
    if (self.segmentStyle == XYSegmentStyleText) {
        return XYTextStyleWidth * titleList.count + 10 * (titleList.count - 1);
    }
    return totalLength;
}

-(void)setTitleLists:(NSArray *)titleLists{
    if (self.buttonArray.count > 0) {
        for (int i = 0; i < titleLists.count; i++) {
            [self setTitle:titleLists[i] atIndex:i];
        }
    }else{
        [self setItems:titleLists];
    }
}


-(void)setItems:(NSArray *)items{
    if (self.xy_backgroundColor == nil) {
        [self setBackgroundColor:self.backGroundColor];
    }else{
        [self setBackgroundColor:self.xy_backgroundColor];
    }
    self.buttonStyleTopMargin = self.buttonSelectedTopStyle == ButtonSelectedStyleTop ? 0:self.buttonSelectedTopStyle == ButtonSelectedStyleCenter ? (self.frame.size.height - XYStyleHeight)*0.5 : (self.frame.size.height - XYStyleHeight);
    CGFloat itemsTotalWidth = [self totalLengthForTitleList:items];
    if ( itemsTotalWidth > self.frame.size.width) {
        self.leftMargin = 10;
        self.contentSize = CGSizeMake(itemsTotalWidth + 2 * self.leftMargin, 0);
    }else{
        self.leftMargin = (self.frame.size.width - itemsTotalWidth) * 0.5;
    }
    
    //    self.backgroundColor = [UIColor blueColor];
    self.maxOriginX = self.leftMargin;
    for (int i = 0; i < items.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.maxOriginX, self.buttonStyleTopMargin, [self lengthForItem:items[i]], self.buttonStyleHeight)];
        button.tag = i;
        [self button:button setItem:items[i]];
        self.maxOriginX = CGRectGetMaxX(button.frame) + self.buttonMargin;
        [self.buttonArray addObject:button];
        [self addSubview:button];
    }
    UIButton *firstbutton = (UIButton *)self.buttonArray[0];
    [self setButtonStyleFrame:firstbutton.frame];
    self.selectedButton = firstbutton;
    [self setSelectedButtonStyle];
}

-(void)button:(UIButton *)button setItem:(NSString *)title{
    [button setTitle:title forState:UIControlStateNormal];
    //    [button setTitle:title forState:UIControlStateSelected];
    
    [button setTitleColor:self.xy_itemDefaultColor forState:UIControlStateNormal];
    button.titleLabel.font = self.textFont;
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setSelectedButtonStyle{
    

    [self.selectedButton setTitleColor:self.xy_itemSelectedColor forState:UIControlStateNormal];
    
//#warning 选中加粗  [self.selectedButton.titleLabel setFont:[UIFont boldSystemFontOfSize:self.textFont.pointSize]];
    [self.selectedButton.titleLabel setFont:[UIFont systemFontOfSize:self.textFont.pointSize]];
    
}

-(void)setDeSelectedButtonStyle{
    
    self.selectedButton.titleLabel.font = [UIFont systemFontOfSize:self.textFont.pointSize];
    [self.selectedButton setTitleColor:self.xy_itemDefaultColor forState:UIControlStateNormal];
    
}



-(void)setButtonStyleFrame:(CGRect)frame{
    self.buttonStyle.frame = frame;
    self.buttonStyleImageView.frame = self.buttonStyle.bounds;
}

-(void)itemClick:(id)sender{
    UIButton *button = sender;
    
    if (self.selectedButton != button) {
        [self setDeSelectedButtonStyle];
        [button.titleLabel setFont:[UIFont systemFontOfSize:self.textFont.pointSize]];
        self.selectedButton = button;
        [self setSelectedButtonStyle];
        [self setSelectedIndex:button.tag];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setButtonStyleFrame:button.frame];
        } completion:^(BOOL finished) {
            self.selectIndex = button.tag;
        }];
        
    }
    CGFloat offsetX = CGRectGetMinX(self.selectedButton.frame);
    if (self.contentOffset.x + 10 > offsetX) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentOffset = CGPointMake(offsetX - 10, 0);
        }];
        
    }
    
    offsetX = CGRectGetMaxX(self.selectedButton.frame);
    if (offsetX + 10 > self.frame.size.width + self.contentOffset.x) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentOffset = CGPointMake(offsetX - self.frame.size.width + 10, 0);
        }];
    }
    
    
    [self setSelectedButtonStyle];
    
}



- (void)xy_itemClickByIndex:(NSInteger)index{
    if (index < 0) {
        return;
    }
    UIButton *item = (UIButton *)self.buttonArray[index];
    [self itemClick:item];
}

/**
 *  根据索引跳转到对应的Button
 */
- (void) setSelectedIndex:(NSUInteger)index{
    [self xy_itemClickByIndex:index];
    if (_sblock) {
        _sblock(index);
    }
}
/**
 *  选中Button执行的Block回调
 */
- (void) didSelectedOneSegment:(XYSSegmentDidSelectedBlock) block{
    _sblock = block;
}
/**
 *  设置Button标题后面的数字
 */
- (void) setItemNmu:(NSUInteger)num atIndex:(NSUInteger)index{
    if ([self.buttonArray count]>index && num != 0) {
        UIButton *button = self.buttonArray[index];
        NSString *title = button.titleLabel.text;
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:&error];
        NSTextCheckingResult *result = [regex firstMatchInString:title options:0 range:NSMakeRange(0, [title length])];
        NSString *buttonTitle;
        if (result) {
            buttonTitle = [title substringWithRange :NSMakeRange(0,result.range.location)];
        }else{
            buttonTitle = title;
        }
        NSString *titleWithnum = [NSString stringWithFormat:@"%@%ld",buttonTitle,(long)num];
        
        [self setTitle:titleWithnum atIndex:index];
    }
}



-(void)setLineViewShow:(BOOL)lineViewShow{
    _lineViewShow = lineViewShow;
    CGFloat TTScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat TTMainScale = 1/ [UIScreen mainScreen].scale;
    CGFloat lineWidth = self.maxOriginX > TTScreenWidth ? self.maxOriginX + 10 : TTScreenWidth;
    if (lineViewShow) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1/TTMainScale, lineWidth, 1/TTMainScale)];
        lineView.backgroundColor = [UIColor colorWithRGBHex:0xE8E8E8];
        [self addSubview:lineView];
    }
}
/**
 *  设置Button后面的红点
 */
- (void)setRedPointAtIndex:(NSUInteger)index{
    if ([self.buttonArray count]>index) {
        UIButton *button = self.buttonArray[index];
        
        UIImage *yuyinImage = [UIImage imageNamed:@"dian"];
        NSString *strtitle = button.titleLabel.text;
        NSDictionary *attribute = @{NSFontAttributeName: self.textFont};
        CGRect rect = [strtitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attribute
                                             context:nil];
        UIImageView *redPoint = [[UIImageView alloc]initWithImage:yuyinImage];
        redPoint.frame = CGRectMake((button.bounds.size.width+rect.size.width)*0.5 + 2, (button.bounds.size.height - self.textFont.pointSize*0.8)*0.5, self.textFont.pointSize*0.8,self.textFont.pointSize*0.8);
        [button addSubview:redPoint];
        
    }
    
}
/**
 *  移除Button后面的红点
 */
- (void)removeRedPointAtIndex:(NSUInteger)index{
    if ([self.buttonArray count]>index) {
        UIButton *button = self.buttonArray[index];
        NSArray *subViews = [button subviews];
        for (UIView *subView in subViews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [subView removeFromSuperview];
            }
        }
    }
    
}

- (void) setTitle:(NSString *)title atIndex:(NSInteger) index{
    if ([self.buttonArray count]>index) {
        UIButton *btn = [self.buttonArray objectAtIndex:index];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateSelected];
    }
}

- (void)moveButtonStyleWithScrollView:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    if (self.selectIndex >= 0 && self.buttonArray.count > 0) {
        UIButton *previousButton = self.selectIndex != 0 ? self.buttonArray[self.selectIndex - 1] : self.buttonArray[self.selectIndex];
        UIButton *nextButton = self.selectIndex != self.buttonArray.count-1 ? self.buttonArray[self.selectIndex + 1] : self.buttonArray[self.selectIndex];
        
        //    前后button与当前button的orgin的x差值
        CGFloat previousDifference = CGRectGetMinX(previousButton.frame) - CGRectGetMinX(self.selectedButton.frame);
        CGFloat nextDifference = CGRectGetMinX(nextButton.frame) - CGRectGetMinX(self.selectedButton.frame);
        //    前后button与当前button 的宽度的差值
        CGFloat nextbuttonWidthDifference = CGRectGetWidth(nextButton.frame) - self.selectedButton.frame.size.width;
        CGFloat previousButtonWidthDifference = CGRectGetWidth(previousButton.frame) - self.selectedButton.frame.size.width;
        CGFloat colorOffset;
        if(offset > self.selectIndex){
            
            CGFloat buttonStyleWidth = CGRectGetWidth(self.selectedButton.frame) + (offset-self.selectIndex) * nextbuttonWidthDifference;
            //
            buttonStyleWidth = buttonStyleWidth <= 60 ? 60 : buttonStyleWidth;
            
            [self setButtonStyleFrame:CGRectMake(CGRectGetMinX(self.selectedButton.frame) + (offset-self.selectIndex) * nextDifference, self.buttonStyleTopMargin, buttonStyleWidth, self.buttonStyleHeight)];
            
            colorOffset = offset - (int)offset;
            
            if (offset - self.selectIndex < 1) {
                CGFloat alphaBefore = 1;
                CGFloat alphaNow = 1;
                if (self.segmentStyle == XYSegmentStyleT02) {
                    alphaBefore = 0.5 + 0.5 * colorOffset;
                    alphaNow = 1.0 - 0.5 * colorOffset;
                }
                [nextButton setTitleColor:[self changNextColorWithOffset:colorOffset alpha:alphaBefore] forState:UIControlStateNormal];
                [self.selectedButton setTitleColor:[self changColorPreviousWithOffset:colorOffset alpha:alphaNow] forState:UIControlStateNormal];
                
            }
            
            if(offset - self.selectIndex > 1){
                [self setDeSelectedButtonStyle];
                
                nextButton.titleLabel.font = [UIFont systemFontOfSize:self.textFont.pointSize];
                [nextButton setTitleColor:self.xy_itemDefaultColor forState:UIControlStateNormal];
                
            }
            
        }else{
            CGFloat buttonStyleWidth = CGRectGetWidth(self.selectedButton.frame) + (self.selectIndex - offset) * previousButtonWidthDifference;
            
            buttonStyleWidth = buttonStyleWidth <= 60 ? 60 : buttonStyleWidth;
            
            [self setButtonStyleFrame:CGRectMake(CGRectGetMinX(self.selectedButton.frame) + (self.selectIndex - offset) * previousDifference , self.buttonStyleTopMargin,buttonStyleWidth, self.buttonStyleHeight)];
            
            
            
            colorOffset = ceilf(offset) - offset;
            
            
            if (self.selectIndex - offset <= 1) {
                CGFloat alphaBefore = 1;
                CGFloat alphaNow = 1;
                if (self.segmentStyle == XYSegmentStyleT02) {
                    alphaBefore = 0.5 + 0.5 * colorOffset;
                    alphaNow = 1.0 - 0.5 * colorOffset;
                }
                
                [previousButton setTitleColor:[self changNextColorWithOffset:colorOffset alpha:alphaBefore] forState:UIControlStateNormal];
                [self.selectedButton setTitleColor:[self changColorPreviousWithOffset:colorOffset alpha:alphaNow] forState:UIControlStateNormal];
                
            }
            if (self.selectIndex - offset > 1) {
                [self setDeSelectedButtonStyle];
                
                previousButton.titleLabel.font = [UIFont systemFontOfSize:self.textFont.pointSize];
                [previousButton setTitleColor:self.xy_itemDefaultColor forState:UIControlStateNormal];
            }
            
        }
        
        
        //    当offset接近完成整页滚动的时候，手动调用点击事件
        int buttonIndex = (int)(offset * 1000000) % 1000000;
        if (buttonIndex == 0) {
            [self itemClick:self.buttonArray[(int)offset]];
        }

    }
}


//下一个按钮要变的颜色
- (UIColor *)changNextColorWithOffset:(CGFloat)offset alpha:(CGFloat)alpha{
    UIColor *selectColor = self.xy_itemSelectedColor;
    const CGFloat *components = CGColorGetComponents(selectColor.CGColor);
    
    UIColor *defaultColor = self.xy_itemDefaultColor;
    const CGFloat *componentNormal = CGColorGetComponents(defaultColor.CGColor);
    UIColor *changeNextColor = [UIColor colorWithRed:(componentNormal[0] + (components[0] -componentNormal[0]) * offset) green:(componentNormal[1] + (components[1] -componentNormal[1]) * offset ) blue:(componentNormal[2] + (components[2] -componentNormal[2]) * offset) alpha:alpha];
    return changeNextColor;
}

//当前按钮要变的颜色
-(UIColor *)changColorPreviousWithOffset:(CGFloat)offset alpha:(CGFloat)alpha{
    UIColor *selectColor = self.xy_itemSelectedColor;
    const CGFloat *components = CGColorGetComponents(selectColor.CGColor);
    
    UIColor *defaultColor = self.xy_itemDefaultColor;
    const CGFloat *componentNormal = CGColorGetComponents(defaultColor.CGColor);
    UIColor *changePreviousColor = [UIColor colorWithRed:(components[0] + (componentNormal[0] - components[0]) * offset) green:(components[1] + (componentNormal[1] - components[1]) * offset) blue:(components[2] + (componentNormal[2] - components[2]) * offset) alpha:alpha];
    return changePreviousColor;
}

@end
