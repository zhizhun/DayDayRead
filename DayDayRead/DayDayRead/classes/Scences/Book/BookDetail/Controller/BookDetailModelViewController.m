//
//  BookDetailModelViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/7/2.
//  Copyright © 2016年 王志准. All rights reserved.
//

#import "BookDetailModelViewController.h"
#import "BookHeaderModel.h"
#import "BookDetailModel.h"
#import "BookHeaderModelCell.h"
#import "BookDetailModelCell.h"
#import "NetWorkRequestManager.h"
#import "Tool.h"
#import "BeforeReadViewController.h"
#import "ShareFundationViewController.h"
@interface BookDetailModelViewController ()
@property (nonatomic, strong) NSMutableArray *allHeader;

@property (nonatomic, strong) NSMutableArray *allDetail;


@end

@implementation BookDetailModelViewController

- (NSMutableArray *)allHeader {
    
    if (!_allHeader) {
        _allHeader = [NSMutableArray array];
    }
    return _allHeader;
}

- (NSMutableArray *)allDetail {
    
    if (!_allDetail) {
        _allDetail = [NSMutableArray array];
    }
    return _allDetail;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
    [self requestDataOne];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BookHeaderModelCell" bundle:nil] forCellReuseIdentifier:@"header"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookDetailModelCell" bundle:nil] forCellReuseIdentifier:@"detail"];
    
   
}

- (void)requestData {
    //1.使用urlSession
    NSURLSession *session = [NSURLSession sharedSession];
    //2.准备url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.zhuishushenqi.com/book-list/%@", __id]];
    //3.设置request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"YouShaQi/2.25.0 (iPod touch; iOS 9.1; Scale/2.00) Paros/3.2.13" forHTTPHeaderField:@"User-Agent"];
    //链接并发送请求
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *dict = [dic objectForKey:@"bookList"];
            BookHeaderModel *model = [[BookHeaderModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.allHeader addObject:model];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            if (!data) {
                NSLog(@"请求数据为空");
            }
            
        }
    }];
    [task resume];

}

- (void)requestDataOne {
    //1.使用urlSession
    NSURLSession *session = [NSURLSession sharedSession];
    //2.准备url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.zhuishushenqi.com/book-list/%@", __id]];
    //3.设置request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"YouShaQi/2.25.0 (iPod touch; iOS 9.1; Scale/2.00) Paros/3.2.13" forHTTPHeaderField:@"User-Agent"];
    //链接并发送请求
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *dict = [dic objectForKey:@"bookList"];
            
            NSArray *array = [dict objectForKey:@"books"];
            
            for (NSDictionary *dictionary in array) {
                
                NSDictionary *dict1 = dictionary[@"book"];
                
                BookDetailModel *detail = [[BookDetailModel alloc] init];
                [detail setValuesForKeysWithDictionary:dict1];
                [self.allDetail addObject:detail];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            if (!data) {
                NSLog(@"请求数据为空");
            }
            
        }
    }];
    [task resume];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.allHeader.count;
    } else {
        return self.allDetail.count;
}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   
    if (indexPath.section == 0) {
        BookHeaderModelCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"header" forIndexPath:indexPath];
        BookHeaderModel *header = self.allHeader[indexPath.row];
        headerCell.header = header;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(self.view.frame.size.width-70, 20, 60, 30);
        [button setTitle:@"分享" forState:UIControlStateNormal];
        button.tintColor = [UIColor grayColor];
        [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerCell addSubview:button];
        
        return headerCell;
    } else {
        BookDetailModelCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
        BookDetailModel *detail = self.allDetail[indexPath.row];
        detailCell.detail = detail;
        return detailCell;
    }
}


// 分享
- (void)nextAction:(UIButton *)sender {
    
//    BookHeaderModel *model = self.allHeader[0];
//    
//      
//    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:[model.author objectForKey:@"avatar"]];
//    [UMSocialData defaultData].extConfig.title = model.title;
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"507fcab25270157b37000010"
//                                      shareText:model.desc
//                                     shareImage:[UIImage imageNamed:@"book"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
//                                       delegate:self];
}

//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        BookHeaderModel *model = self.allHeader[indexPath.row];
        
        CGFloat authorH = [Tool calculateTextHeightWithMovie:[model.author objectForKey:@"nickname"] LabelWidth:self.view.frame.size.width - 70 font:16.0];
        CGFloat titleH = [Tool calculateTextHeightWithMovie:model.title LabelWidth:self.view.frame.size.width - 70 font:20.0];
        CGFloat deseH = [Tool calculateTextHeightWithMovie:model.desc LabelWidth:self.view.frame.size.width - 70 font:17.0];
        return authorH*2+titleH+deseH+100;
    } else {
        BookDetailModel *model = self.allDetail[indexPath.row];
        CGFloat title = [Tool calculateTextHeightWithMovie:model.title LabelWidth:self.view.frame.size.width - 70 font:20.0];
        CGFloat contH = [Tool calculateTextHeightWithMovie:model.author LabelWidth:self.view.frame.size.width - 70 font:16.0];
        return title+contH+60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section != 0) {
        
        BeforeReadViewController *beforVC = [[BeforeReadViewController alloc] init];
        BookDetailModel *model = self.allDetail[indexPath.row];
        beforVC._id = (NSString *)model._id;
        NSLog(@"----%@___", model._id);
        [self.navigationController pushViewController:beforVC animated:YES];
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
