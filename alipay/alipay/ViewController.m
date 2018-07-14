//
//  ViewController.m
//  alipay
//
//  Created by Bleach on 2018/7/14.
//  Copyright © 2018年 Bleach.zhen. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define RGBA(rgbValue, opacity) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:opacity]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *normalItemArray;
@property (nonatomic, strong) NSMutableArray *coverItemArray;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *itemView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItems = self.normalItemArray;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.itemView];
    [self.scrollView addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"123123123");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
        });
    }];
    
    self.scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(self.tableView.frame)+20);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// lazy
-(UIScrollView *)scrollView{
    if(_scrollView == nil){
        CGFloat NavBarHeight = 0.0;
        if(HEIGHT == 812.0){
            NavBarHeight = 88.0f;
        }else{
            NavBarHeight = 64.0f;
        }
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-NavBarHeight)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIView *)itemView{
    if(_itemView == nil){
        _itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
        _itemView.backgroundColor = [UIColor blueColor];
        
        UIButton *one = [UIButton buttonWithType:UIButtonTypeCustom];
        [one setImage:[UIImage imageNamed:@"21天包换-2"] forState:UIControlStateNormal];
        one.tintColor = [UIColor whiteColor];
        [one addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_itemView addSubview:one];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_itemView);
            make.width.height.mas_equalTo(WIDTH/4.0);
        }];
        
        UIButton *two = [UIButton buttonWithType:UIButtonTypeCustom];
        [two setImage:[UIImage imageNamed:@"24小时发货-2"] forState:UIControlStateNormal];
        two.tintColor = [UIColor whiteColor];
        [two addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_itemView addSubview:two];
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(one.mas_right);
            make.top.mas_equalTo(_itemView);
            make.width.height.mas_equalTo(WIDTH/4.0);
        }];
        
        UIButton *three = [UIButton buttonWithType:UIButtonTypeCustom];
        [three setImage:[UIImage imageNamed:@"48小时发货-2"] forState:UIControlStateNormal];
        three.tintColor = [UIColor whiteColor];
        [three addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_itemView addSubview:three];
        [three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(two.mas_right);
            make.top.mas_equalTo(_itemView);
            make.width.height.mas_equalTo(WIDTH/4.0);
        }];
        
        UIButton *four = [UIButton buttonWithType:UIButtonTypeCustom];
        [four setImage:[UIImage imageNamed:@"60天包换-2"] forState:UIControlStateNormal];
        four.tintColor = [UIColor whiteColor];
        [four addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_itemView addSubview:four];
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(three.mas_right);
            make.top.mas_equalTo(_itemView);
            make.width.height.mas_equalTo(WIDTH/4.0);
        }];
    }
    return _itemView;
}

-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 700) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
        CGFloat y = scrollView.contentOffset.y;
        if (y < -65) {
            [self.tableView.mj_header beginRefreshing];
        }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.tableView){
        return;
    }
    CGFloat y = scrollView.contentOffset.y;
    if (y <= 0) {
        CGRect frame = self.itemView.frame;
        frame.origin.y = y;
        self.itemView.frame= frame;
        
        CGRect TFrame = self.tableView.frame;
        if (![self.tableView.mj_header isRefreshing]) {
            self.tableView.contentOffset = CGPointMake(0, y);
        }
        [self.tableView setFrame:TFrame];
    }else {
        // 功能view视觉差
        CGRect frame = self.itemView.frame;
        frame.origin.y = y/2.0;
        self.itemView.frame= frame;
    }
    
    float alpha = (1 - y/150) >0 ? (1 - y/150): 0;
    if(alpha>0.5){
        for(int i=0;i<self.normalItemArray.count;i++){
            UIBarButtonItem *item = (UIBarButtonItem *)[self.normalItemArray objectAtIndex:i];
            item.tintColor = RGBA(0xFFFFFF, alpha * 2 - 0.8);
        }
        self.navigationItem.leftBarButtonItems = self.normalItemArray;
    }else{
        for(int i=0;i<self.coverItemArray.count;i++){
            UIBarButtonItem *item = (UIBarButtonItem *)[self.coverItemArray objectAtIndex:i];
            item.tintColor = RGBA(0xFFFFFF, 1.2 - alpha * 2);
        }
        self.navigationItem.leftBarButtonItems = self.coverItemArray;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    cell.textLabel.text = [NSString stringWithFormat:@"%li",indexPath.row+1];
    return cell;
}


-(NSMutableArray *)normalItemArray{
    if(_normalItemArray == nil){
        _normalItemArray = [NSMutableArray array];
        
        UIBarButtonItem *itemOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wxb搜索推广"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemOne.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *itemTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wxb定位"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemTwo.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *itemThree = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-youhuiquan"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemThree.tintColor = [UIColor whiteColor];
        
        [_normalItemArray addObject:itemOne];
        [_normalItemArray addObject:itemTwo];
        [_normalItemArray addObject:itemThree];
        
    }
    return _normalItemArray;
}

-(NSMutableArray *)coverItemArray{
    if(_coverItemArray == nil){
        _coverItemArray = [NSMutableArray array];
        
        UIBarButtonItem *itemOne = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"21天包换"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemOne.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *itemTwo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"24小时发货"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemTwo.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *itemThree = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"48小时发货"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemThree.tintColor = [UIColor whiteColor];
        
        UIBarButtonItem *itemFour = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"60天包换"] style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
        itemFour.tintColor = [UIColor whiteColor];
        
        [_coverItemArray addObject:itemOne];
        [_coverItemArray addObject:itemTwo];
        [_coverItemArray addObject:itemThree];
        [_coverItemArray addObject:itemFour];
    }
    return _coverItemArray;
}
-(void)itemClick:(id)item{
    if([item isKindOfClass:[UIBarButtonItem class]]){
        NSLog(@"BarButton:---%@",item);
    }else if([item isKindOfClass:[UIButton class]]){
        NSLog(@"Button:---%@",item);
    }else{
        return;
    }
}

@end
