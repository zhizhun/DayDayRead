//
//  DynamicMineViewController.m
//  项目
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicMineViewController.h"
#import "MyInformationViewController.h"
#import "DynamicColumnDetailViewController.h"
#import <Masonry.h>
#import "DynamicManager.h"
#import "ArchiverHandle.h"
#import "UserFileHandle.h"
#import "DynamicCell.h"
#import "Dynamic.h"
#import <UIImageView+WebCache.h>
#import "MyInformationCell.h"
#define kSpace 10

@interface DynamicMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;

//头像
@property (nonatomic,strong)UIImageView *avatarImageView;
//名称
@property (nonatomic, strong)UILabel *nameLabel;
//关注数量
@property (nonatomic, strong)UILabel *attentionNumLabel;
//关注
@property (nonatomic, strong)UILabel *attentionLabel;
//粉丝数量
@property (nonatomic, strong)UILabel *fansNumLabel;
//粉丝
@property (nonatomic, strong)UILabel *fansLabel;
//编辑按钮
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DynamicMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
//    self.dataArray = [NSMutableArray array];
    
}
- (void)initView{
    __weak typeof(DynamicMineViewController *)dynamicVC = self;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dynamicVC.view);
        make.left.equalTo (dynamicVC.view);
        make.width.mas_equalTo(dynamicVC.view.frame.size.width);
        make.height.mas_equalTo (120);
        
    }];
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.image = [UIImage imageNamed:@"1.jpg"];
    [backView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (backView).offset(kSpace);
        make.left.equalTo (backView).offset(kSpace);
        make.width.mas_equalTo (60);
        make.height.mas_equalTo (60);
    }];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"维他命";
    
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(kSpace);
        make.left.equalTo (self.avatarImageView.mas_right).offset (kSpace);
        make.right.equalTo (backView).offset(-30);
        
        make.height.mas_equalTo (15);
        
    }];
    self.attentionNumLabel = [[UILabel alloc] init];
    self.attentionNumLabel.text = @"50";
    self.attentionNumLabel.font = [UIFont systemFontOfSize:12.0];
    [backView addSubview:self.attentionNumLabel];
    [self.attentionNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(kSpace);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(10);
        
    }];
    self.fansNumLabel = [[UILabel alloc] init];
    self.fansNumLabel.text = @"50";
    self.fansNumLabel.font = [UIFont systemFontOfSize:12.0];
    [backView addSubview:self.fansNumLabel];
    [self.fansNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionNumLabel.mas_right).offset(kSpace);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(10);
        
    }];
    
    self.attentionLabel = [[UILabel alloc] init];
    self.attentionLabel.text = @"关注";
    self.attentionLabel.font = [UIFont systemFontOfSize:12.0];
    [backView addSubview:self.attentionLabel];
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(kSpace);
        make.top.equalTo(self.attentionNumLabel.mas_bottom).offset(kSpace/2);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(10);
        
    }];
    
    self.fansLabel = [[UILabel alloc] init];
    self.fansLabel.text = @"粉丝";
    self.fansLabel.font = [UIFont systemFontOfSize:12.0];
    [backView addSubview:self.fansLabel];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionLabel.mas_right).offset(kSpace+10);
        make.top.equalTo(self.fansNumLabel.mas_bottom).offset(kSpace/2);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(10);
        
    }];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor brownColor];
    [self.button setTitle:@"编辑" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.button];
    
    
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kSpace * 2);
        make.right.equalTo(backView).offset(-kSpace * 2);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - backView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
   
}
- (void)buttonClicked {
    MyInformationViewController *myInfoVC = [[MyInformationViewController alloc] init];
    
    [self.navigationController pushViewController:myInfoVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
   
    self.dataArray = [[DynamicManager shareDynamicManager]selectAllDynamic];
   
    [self.tableView reloadData];
}

#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"已转发列表";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Dynamic *dynamic = self.dataArray[indexPath.row];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    titleLabel.numberOfLines = 2;
    [cell.contentView addSubview:titleLabel];
    titleLabel.text = [dynamic.refTweet objectForKey:@"title"];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [cell.contentView addSubview:imageView1];
    NSString *imageStr = [dynamic.from objectForKey:@"avatar"];
    NSString *urlStr= @"http://statics.zhuishushenqi.com/";
    NSString *imageViewStr = [NSString stringWithFormat:@"%@%@",urlStr,imageStr];
    
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:imageViewStr]];
    
  
    
    return cell;
}

#pragma mark 实现删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 删除数据源
        Dynamic *dynamic = self.dataArray[indexPath.row];
        [[DynamicManager shareDynamicManager]deleteDynamic:dynamic];;
        [_dataArray removeObject:dynamic];
        // 更新页面
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicColumnDetailViewController *dynamicDetailVC = [[DynamicColumnDetailViewController alloc] init];
    
    
    
    Dynamic *dynamic = self.dataArray[indexPath.row];
    dynamicDetailVC.dynamic = dynamic;
    
    [self.navigationController pushViewController:dynamicDetailVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
