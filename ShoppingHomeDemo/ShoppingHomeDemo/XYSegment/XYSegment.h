//
//  XYSegment.h
//  SugemtTest
//
//  Created by Raymone on 16/4/12.
//  Copyright © 2016年 Raymone. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  样式
 */
typedef enum {
    XYSegmentStyleT01,
    
    XYSegmentStyleT02,
    
    XYSegmentStyleT03,
    /**
     *  线条样式
     */
    XYSegmentStyleLine,
    /**
     *  矩形样式
     */
    XYSegmentStyleRectangle,
    /**
     *  文字样式
     */
    XYSegmentStyleText
} XYSSegmentStyle;

typedef enum {
    ButtonSelectedStyleTop,
    ButtonSelectedStyleCenter,
    ButtonSelectedStyleBottom
    
}ButtonSelectedTopStyle;

typedef void (^XYSSegmentDidSelectedBlock)(NSInteger index);

@interface XYSegment : UIScrollView

@property(nonatomic, strong) UIColor *xy_backgroundColor;

@property(nonatomic, assign) ButtonSelectedTopStyle buttonSelectedTopStyle;
// 标题数组
@property(nonatomic, strong) NSArray *titleLists;

@property(nonatomic, readonly) NSInteger selectIndex;

//Set ‘YES’ means show.Default is NO.  
@property(nonatomic, assign) BOOL lineViewShow;
/**
 *  类方法创建
 */
+ (XYSegment *)xy_segmentWithFrame:(CGRect)frame style:(XYSSegmentStyle)style;
/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame style:(XYSSegmentStyle)style;
/**
 *  根据索引触发单击事件
 */
- (void)xy_itemClickByIndex:(NSInteger)index;
/**
 *  设置按钮标题
 */
- (void) setTitle:(NSString *)title atIndex:(NSInteger) index;
/**
 *  根据索引跳转到对应的Button
 */
- (void) setSelectedIndex:(NSUInteger)index;
/**
 *  选中Button执行的Block回调
 */
- (void) didSelectedOneSegment:(XYSSegmentDidSelectedBlock) block;
/**
 *  设置Button标题后面的数字
 */
- (void) setItemNmu:(NSUInteger)num atIndex:(NSUInteger)index;
/**
 *  设置Button后面的红点
 */
- (void)setRedPointAtIndex:(NSUInteger)index;
/**
 *  移除Button后面的红点
 */
- (void)removeRedPointAtIndex:(NSUInteger)index;

- (void)moveButtonStyleWithScrollView:(UIScrollView *)scrollView;

@end
