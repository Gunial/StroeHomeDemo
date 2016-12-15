//
//  ViewController.m
//  ShoppingHomeDemo
//
//  Created by Mr.Gu on 16/12/14.
//  Copyright © 2016年 Mr.Gu. All rights reserved.
//

#import "ViewController.h"
#import "GGSegmentView.h"
#import "GGStoreInfoView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

/** 店铺信息界面(店铺名称,店铺图片,店面名称,关注按钮) */
@property (nonatomic, strong) GGStoreInfoView *infoView;

@property (nonatomic, strong) GGSegmentView *segmentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"店铺首页";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.infoView];
    [self.view addSubview:self.segmentView];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    self.segmentView.offSet = offSetY;
    
    if (offSetY >= -113) {
        offSetY = -113;
    }else {
        if (offSetY <= -264) {
            offSetY = -264;
        }
    }
    
    CGRect infoViewFrame = self.infoView.frame;
    infoViewFrame.origin.y = -200 - offSetY;
    self.infoView.frame = infoViewFrame;
    
    CGRect segmentViewFrame = self.segmentView.frame;
    segmentViewFrame.origin.y = -64 - offSetY;
    self.segmentView.frame = segmentViewFrame;
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
        _tableView.backgroundColor = [UIColor colorWithRed:(240 / 255.0) green:(240 / 255.0) blue:(240 / 255.0) alpha:1.0];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (GGStoreInfoView *)infoView
{
    if (_infoView == nil) {
        _infoView = [[GGStoreInfoView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 136)];
        _infoView.backgroundColor = [UIColor darkGrayColor];
    }
    return _infoView;
}


- (GGSegmentView *)segmentView
{
    if (_segmentView == nil) {
        _segmentView = [[GGSegmentView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 64)];
        _segmentView.backgroundColor = [UIColor whiteColor];
    }
    return _segmentView;
}

@end
