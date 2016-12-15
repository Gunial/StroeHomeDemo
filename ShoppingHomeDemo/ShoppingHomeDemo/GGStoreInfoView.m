//
//  GGStoreInfoView.m
//  ShoppingHomeDemo
//
//  Created by Mr.Gu on 16/12/15.
//  Copyright © 2016年 Mr.Gu. All rights reserved.
//

#import "GGStoreInfoView.h"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation GGStoreInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    
    UILabel *labelOne = [[UILabel alloc] init];
    labelOne.text = @"——嘟宝专卖店";
    labelOne.textColor = [UIColor lightGrayColor];
    labelOne.font = [UIFont systemFontOfSize:25];
    labelOne.frame = CGRectMake(80, 10, 200, 30);
    [self addSubview:labelOne];
    
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"专注高端品质——";
    labelTwo.textColor = [UIColor lightGrayColor];
    labelTwo.font = [UIFont systemFontOfSize:14];
    labelTwo.frame = CGRectMake(self.bounds.size.width - 200, 40, 200, 30);
    [self addSubview:labelTwo];
    
    
    
    UIImageView *storeImage = [[UIImageView alloc] init];
    storeImage.frame = CGRectMake(0, self.bounds.size.height - 50, 50, 50);
    storeImage.image = [UIImage imageNamed:@"shuaiqi"];
    [self addSubview:storeImage];
    
    UILabel *storeName = [[UILabel alloc] init];
    storeName.frame = CGRectMake(65, self.bounds.size.height - 50, 100, 25);
    storeName.textColor = [UIColor whiteColor];
    storeName.font = [UIFont fontWithName:@ "HelveticaNeue-Bold" size:14.0];
    storeName.text = @"嘟宝专卖店";
    [self addSubview:storeName];
    
    UIButton *attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionButton.frame = CGRectMake(self.bounds.size.width - 70, self.bounds.size.height - 40, 60, 30);
    attentionButton.layer.cornerRadius = 5;
    attentionButton.backgroundColor = RGBACOLOR(254, 62, 0, 1.0);
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"attention"];
    attach.bounds = CGRectMake(0, -4, 16, 16);
    NSAttributedString *attributeStr = [NSAttributedString attributedStringWithAttachment:attach];
    [attributeString appendAttributedString:attributeStr];
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@" 关注" attributes:@{NSFontAttributeName:[UIFont fontWithName:@ "HelveticaNeue-Bold" size:12.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attributeString appendAttributedString:titleString];
    [attentionButton setAttributedTitle:attributeString forState:UIControlStateNormal];
    [self addSubview:attentionButton];
    
}

@end
