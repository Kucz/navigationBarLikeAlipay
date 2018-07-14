//
//  ViewController.m
//  AlipayHeader
//
//  Created by Bleach on 2018/7/14.
//  Copyright © 2018年 Bleach.zhen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *normalItemArray;
@property (nonatomic, strong) NSMutableArray *coverItemArray;

@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation ViewController

-(UITableView *)tableview{
    if(_tableview == nil){
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.bounces = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableHeaderView = self.tableHeaderView;
    }
    return _tableview;
}

-(UIView *)tableHeaderView{
    if(_tableHeaderView == nil){
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, deviceWdith, deviceWdith/4.0+10)];
        _tableHeaderView.backgroundColor = [UIColor blueColor];
        
        UIButton *one = [UIButton buttonWithType:UIButtonTypeCustom];
        [one setImage:[UIImage imageNamed:@"21天包换-2"] forState:UIControlStateNormal];
        one.tintColor = [UIColor whiteColor];
        [one addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableHeaderView addSubview:one];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_tableHeaderView);
            make.width.height.mas_equalTo(deviceWdith/4.0);
        }];
        
        UIButton *two = [UIButton buttonWithType:UIButtonTypeCustom];
        [two setImage:[UIImage imageNamed:@"24小时发货-2"] forState:UIControlStateNormal];
        two.tintColor = [UIColor whiteColor];
        [two addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableHeaderView addSubview:two];
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(one.mas_right);
            make.top.mas_equalTo(_tableHeaderView);
            make.width.height.mas_equalTo(deviceWdith/4.0);
        }];
        
        UIButton *three = [UIButton buttonWithType:UIButtonTypeCustom];
        [three setImage:[UIImage imageNamed:@"48小时发货-2"] forState:UIControlStateNormal];
        three.tintColor = [UIColor whiteColor];
        [three addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableHeaderView addSubview:three];
        [three mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(two.mas_right);
            make.top.mas_equalTo(_tableHeaderView);
            make.width.height.mas_equalTo(deviceWdith/4.0);
        }];
        
        UIButton *four = [UIButton buttonWithType:UIButtonTypeCustom];
        [four setImage:[UIImage imageNamed:@"60天包换-2"] forState:UIControlStateNormal];
        four.tintColor = [UIColor whiteColor];
        [four addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tableHeaderView addSubview:four];
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(three.mas_right);
            make.top.mas_equalTo(_tableHeaderView);
            make.width.height.mas_equalTo(deviceWdith/4.0);
        }];
    }
    return _tableHeaderView;
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItems = self.normalItemArray;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    cell.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%li",indexPath.row];
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float y = scrollView.contentOffset.y;
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



@end
