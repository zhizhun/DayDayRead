//
//  SearchViewController.m
//  DayDayRead
//
//  Created by 王志准 on 16/6/26.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "SearchViewController.h"
#import "URL.h"
#import "NetWorkRequestManager.h"
#import "Tool.h"
#import "DB_COLOR.h"
#import "ResultsViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>
//搜索框
@property (nonatomic,strong)UISearchBar *searchBar;
//数组
@property (nonatomic,strong)NSArray *allArray;
@property (nonatomic,strong)UIView *searchView;
@property (nonatomic,strong)UIView *seaView;

@end

@implementation SearchViewController
//懒加载
- (NSArray *)allArray{
    if (!_allArray) {
        _allArray = [NSArray array];
    }
    return _allArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏设置
    self.title = @"搜索";
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)];
    self.navigationItem.rightBarButtonItem = searchItem;
    //请求数据
    [self loadData];

}
- (void)loadData{
    [NetWorkRequestManager requestType:GET urlString:SEARCH_LIST_URL prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.allArray = [dict objectForKey:@"hotWords"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)initView{
    //搜索框
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.searchBar.placeholder = @"输入书名或作者名";
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    [self.view addSubview:self.searchBar];
    //大家都在搜
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.searchBar.frame.size.height+15, 100, 40)];
    label.text = @"大家都在搜";
    [self.view addSubview:label];
    //换一批
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(self.view.frame.size.width-100, label.frame.origin.y, 90, 40);
    [searchButton setTitle:@"换一批" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    //搜的内容
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height+60, self.view.frame.size.width, 70)];
    [self.view addSubview:self.searchView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [Tool textWidthWithText:self.allArray[0] font:[UIFont systemFontOfSize:17]], 30)];
    label1.text = self.allArray[0];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:15];
    label1.backgroundColor = DB_RANDOM_COLOR;
    [self.searchView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+20, 0, [Tool textWidthWithText:self.allArray[1] font:[UIFont systemFontOfSize:17]], 30)];
    label2.text = self.allArray[1];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:15];
    label2.backgroundColor = DB_RANDOM_COLOR;
    [self.searchView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame)+15, [Tool textWidthWithText:self.allArray[2] font:[UIFont systemFontOfSize:17]], 30)];
    label3.text = self.allArray[2];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:15];
    label3.backgroundColor = DB_RANDOM_COLOR;
    [self.searchView addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame)+20, CGRectGetMaxY(label1.frame)+15, [Tool textWidthWithText:self.allArray[3] font:[UIFont systemFontOfSize:17]], 30)];
    label4.text = self.allArray[3];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:15];
    label4.backgroundColor = DB_RANDOM_COLOR;
    [self.searchView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label3.frame)+15, [Tool textWidthWithText:self.allArray[4] font:[UIFont systemFontOfSize:17]], 30)];
    label5.text = self.allArray[4];
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = [UIFont systemFontOfSize:15];
    label5.backgroundColor = DB_RANDOM_COLOR;
    [self.searchView addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame)+20, CGRectGetMaxY(label4.frame)+15, [Tool textWidthWithText:self.allArray[5] font:[UIFont systemFontOfSize:17]], 30)];
    label6.text = self.allArray[5];
    label6.textAlignment = NSTextAlignmentCenter;
    label6.font = [UIFont systemFontOfSize:15];
    label6.backgroundColor = DB_RANDOM_COLOR;
    [self.searchView addSubview:label6];

}
//换一批
- (void)didButton:(UIButton *)sender{
    if (_searchView) {
        [self.searchView removeFromSuperview];
        self.searchView = nil;
        self.seaView = [[UIView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height+60, self.view.frame.size.width, 70)];
        [self.view addSubview:self.seaView];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [Tool textWidthWithText:self.allArray[6] font:[UIFont systemFontOfSize:17]], 30)];
        label1.text = self.allArray[6];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:15];
        label1.backgroundColor = DB_RANDOM_COLOR;
        [self.seaView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+20, 0, [Tool textWidthWithText:self.allArray[7] font:[UIFont systemFontOfSize:17]], 30)];
        label2.text = self.allArray[7];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont systemFontOfSize:15];
        label2.backgroundColor = DB_RANDOM_COLOR;
        [self.seaView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame)+15, [Tool textWidthWithText:self.allArray[8] font:[UIFont systemFontOfSize:17]], 30)];
        label3.text = self.allArray[8];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:15];
        label3.backgroundColor = DB_RANDOM_COLOR;
        [self.seaView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame)+20, CGRectGetMaxY(label1.frame)+15, [Tool textWidthWithText:self.allArray[9] font:[UIFont systemFontOfSize:17]], 30)];
        label4.text = self.allArray[9];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.font = [UIFont systemFontOfSize:15];
        label4.backgroundColor = DB_RANDOM_COLOR;
        [self.seaView addSubview:label4];
        
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label3.frame)+15, [Tool textWidthWithText:self.allArray[10] font:[UIFont systemFontOfSize:17]], 30)];
        label5.text = self.allArray[10];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.font = [UIFont systemFontOfSize:15];
        label5.backgroundColor = DB_RANDOM_COLOR;
        [self.seaView addSubview:label5];
        
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame)+20, CGRectGetMaxY(label4.frame)+15, [Tool textWidthWithText:self.allArray[11] font:[UIFont systemFontOfSize:17]], 30)];
        label6.text = self.allArray[11];
        label6.textAlignment = NSTextAlignmentCenter;
        label6.font = [UIFont systemFontOfSize:15];
        label6.backgroundColor = DB_RANDOM_COLOR;
        [self.seaView addSubview:label6];

    }else{
        [self.seaView removeFromSuperview];
        self.seaView = nil;
        self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height+60, self.view.frame.size.width, 70)];
        [self.view addSubview:self.searchView];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [Tool textWidthWithText:self.allArray[0] font:[UIFont systemFontOfSize:17]], 30)];
        label1.text = self.allArray[0];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:15];
        label1.backgroundColor = DB_RANDOM_COLOR;
        [self.searchView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+20, 0, [Tool textWidthWithText:self.allArray[1] font:[UIFont systemFontOfSize:17]], 30)];
        label2.text = self.allArray[1];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont systemFontOfSize:15];
        label2.backgroundColor = DB_RANDOM_COLOR;
        [self.searchView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame)+15, [Tool textWidthWithText:self.allArray[2] font:[UIFont systemFontOfSize:17]], 30)];
        label3.text = self.allArray[2];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:15];
        label3.backgroundColor = DB_RANDOM_COLOR;
        [self.searchView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame)+20, CGRectGetMaxY(label1.frame)+15, [Tool textWidthWithText:self.allArray[3] font:[UIFont systemFontOfSize:17]], 30)];
        label4.text = self.allArray[3];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.font = [UIFont systemFontOfSize:15];
        label4.backgroundColor = DB_RANDOM_COLOR;
        [self.searchView addSubview:label4];
        
        UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(label3.frame)+15, [Tool textWidthWithText:self.allArray[4] font:[UIFont systemFontOfSize:17]], 30)];
        label5.text = self.allArray[4];
        label5.textAlignment = NSTextAlignmentCenter;
        label5.font = [UIFont systemFontOfSize:15];
        label5.backgroundColor = DB_RANDOM_COLOR;
        [self.searchView addSubview:label5];
        
        UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame)+20, CGRectGetMaxY(label4.frame)+15, [Tool textWidthWithText:self.allArray[5] font:[UIFont systemFontOfSize:17]], 30)];
        label6.text = self.allArray[5];
        label6.textAlignment = NSTextAlignmentCenter;
        label6.font = [UIFont systemFontOfSize:15];
        label6.backgroundColor = DB_RANDOM_COLOR;
        [self.searchView addSubview:label6];

    }
    
    
}

//搜索按钮
- (void)searchAction:(UIBarButtonItem *)sender{
    if (![self.searchBar.text isEqualToString:@""]) {
        ResultsViewController *resultVC = [[ResultsViewController alloc] init];
        resultVC.query = self.searchBar.text;
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}
//取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
}


@end
