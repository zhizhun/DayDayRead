//
//  DynamicColumnDetailViewController.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "DynamicColumnDetailViewController.h"
#import "DynamicCell.h"
#import "ComprehensiveDetail.h"
#import "ComprehensiveDetailCell.h"
#import "DynamicDetailCell.h"
#import "NetWorkRequestManager.h"
#import "MJRefresh.h"
#import <UIImageView+WebCache.h>
#import "Tool.h"


@interface DynamicColumnDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *DytableView;
@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)int flag;



@end

@implementation DynamicColumnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"综合讨论";
    self.allArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.DytableView.delegate = self;
    self.DytableView.dataSource = self;
    [self.DytableView registerNib:[UINib nibWithNibName:@"DynamicDetailCell" bundle:nil] forCellReuseIdentifier:@"pp"];
    [self.DytableView registerNib:[UINib nibWithNibName:@"ComprehensiveDetailCell" bundle:nil] forCellReuseIdentifier:@"qq"];
    [self initLayout];
    [self requestData];
    [self downRefresh];
    [self upRefresh];
   
}
- (void)downRefresh {
    self.DytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _flag =0;
        [self requestData];
        
        [self.DytableView.mj_header endRefreshing];
        
    }];
    
}
- (void)upRefresh {
    
    self.DytableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestData];
        
        [self.DytableView.mj_footer endRefreshing];
    }];
    
}

- (void)initLayout {
    
//    NSDictionary *post = [_dynamic.refTweet objectForKey:@"post"];
//   
    NSString *_id =[_dynamic.refTweet objectForKey:@"_id"];
    
//    NSString *_id = _dynamicDetail._id;
    NSString *URLStr = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/user/twitter/%@?start=0&limit=20",_id ];
    [NetWorkRequestManager requestType:GET urlString:URLStr prama:nil success:^(id data) {
        ;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        
            DynamicDetail *dynamicDetail = [DynamicDetail new];
            [dynamicDetail setValuesForKeysWithDictionary:dict];
            [self.allArray addObject:dynamicDetail];
                
  
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.DytableView reloadData ];
            
        });
        
    } fail:^(NSError *error) {
        
        
    }];
 
    
   }
- (void)requestData {
    
//    NSDictionary *post = [_dynamic.refTweet objectForKey:@"post"];
//   http://api.zhuishushenqi.com/user/twitter/5778bdd7ef14ca970991e5cf?start=0&limit=20
//        NSString *_id = [post objectForKey:@"_id"];
   NSString *_id =[_dynamic.refTweet objectForKey:@"_id"];
        NSString *urlStr1 =[NSString stringWithFormat: @"http://api.zhuishushenqi.com/user/twitter/%@/comments?start=0&limit=20",_id];
        NSString *urlStr = [NSString stringWithFormat:urlStr1,_flag];
    
   
    
    [NetWorkRequestManager requestType:GET urlString:urlStr prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"comments"];
        for (NSDictionary *dic in array) {
            ComprehensiveDetail *model = [ComprehensiveDetail new];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
         
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.DytableView reloadData];
        });
    } fail:^(NSError *error) {
        
    }];
    _flag +=20;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.allArray.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pp" forIndexPath:indexPath];
        DynamicDetail *dynamicDetail = self.allArray[indexPath.row];
        cell.dynamicDetail = dynamicDetail;
        return cell;

        
    }
    
    ComprehensiveDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qq" forIndexPath:indexPath];
    ComprehensiveDetail *comprehensiveDetail = self.dataArray[indexPath.row];
    cell.comprehensiveDetail = comprehensiveDetail;
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       DynamicDetail *dynamicDetail = self.allArray[0];
        CGFloat height1 = [Tool calculateTextHeightWithMovie:[dynamicDetail.user objectForKey:@"nickname"] LabelWidth:self.view.frame.size.width-70 font:13.0];
        CGFloat height2 = [Tool calculateTextHeightWithMovie:dynamicDetail.created LabelWidth:self.view.frame.size.width-70 font:13.0];
        CGFloat height3 = [Tool calculateTextHeightWithMovie:[dynamicDetail.tweet objectForKey:@"title"] LabelWidth:self.view.frame.size.width-70 font:13.0];
         CGFloat height4 = [Tool calculateTextHeightWithMovie:[dynamicDetail.tweet objectForKey:@"content"] LabelWidth:self.view.frame.size.width-70 font:13.0];
        
        return 600+height1+height2+height3+height4;
        
    }
    
    ComprehensiveDetail *comprehensiveDetail = self.dataArray[indexPath.row];
    CGFloat height = [Tool calculateTextHeightWithMovie:comprehensiveDetail.content LabelWidth:self.view.frame.size.width-70 font:13.0];
    return 80+height;
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
