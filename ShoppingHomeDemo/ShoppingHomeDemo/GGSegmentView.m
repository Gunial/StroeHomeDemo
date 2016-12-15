//
//  GGSegmentView.m
//  ShoppingHomeDemo
//
//  Created by Mr.Gu on 16/12/14.
//  Copyright © 2016年 Mr.Gu. All rights reserved.
//

#import "GGSegmentView.h"

#define ImageViewWidth 30
#define ImageViewHeigh 30

@implementation GGSegmentView
{
    /** 缓存 */
    NSMutableArray *_imageViewArray;
    NSMutableArray *_labelArray;
    
    NSArray *_imageNames;
    NSArray *_labelTest;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewArray = [NSMutableArray array];
        _labelArray = [NSMutableArray array];
        
        _imageNames = @[@"shop", @"goods", @"new", @"activity"];
        _labelTest = @[@"店铺首页", @"全部商品", @"新品上架", @"店铺动态"];
        
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    CGFloat imageViewMargin = (self.bounds.size.width - 4*ImageViewWidth)/8;
    CGFloat lableWith = self.bounds.size.width /4;
    CGFloat labelHeight = self.bounds.size.height - ImageViewHeigh;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(imageViewMargin + (2 *imageViewMargin + ImageViewWidth) * i, 5, ImageViewWidth, ImageViewHeigh);
        imageView.tag = 10 + i;
        imageView.image = [UIImage imageNamed:_imageNames[i]];
        [self addSubview:imageView];
        [_imageViewArray addObject:imageView];
        
        UILabel *label = [[UILabel alloc ] init];
        label.frame = CGRectMake(lableWith * i , ImageViewHeigh, lableWith, labelHeight);
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = _labelTest[i];
        label.textColor = [UIColor darkTextColor];
        [self addSubview:label];
        [_labelArray addObject:label];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 0.5, self.bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
}


- (void)setOffSet:(CGFloat)offSet
{
    if (offSet <= - 128) {
        offSet = - 128;
    }else{
        if (offSet >= -98) {
            offSet = -98;
        }
    }

    CGFloat proportion = (128 + offSet) / 30;
    CGFloat fontSize = 12 + (18 - 12) * proportion;
    
    for (UIImageView *imageView in _imageViewArray) {
        imageView.alpha = 1- proportion;
    }
    
    for (UILabel *label in _labelArray) {
        
        label.font = [UIFont systemFontOfSize:fontSize];
        
        CGRect labelFrame = label.frame;
        labelFrame.origin.y = ImageViewHeigh - 15*proportion;
        labelFrame.size.height = self.bounds.size.height - ImageViewHeigh + 15*proportion;
        label.frame = labelFrame;
    }
}

@end
