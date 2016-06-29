//
//  ReputablyViewController.m
//  项目
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ReputablyViewController.h"
#import "CommonCell.h"
#import "CommonModel.h"
#import "NetWorkRequestManager.h"
#import "URL.h"
#import "NSString+URL.h"
#import "SingleList.h"

#import "BookStoreViewController.h"

@interface ReputablyViewController ()
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *dataStr;
@property (nonatomic, strong)NSString *textStr;
@end

@implementation ReputablyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SingleList *list = [SingleList shareInstance];
    self.dataStr = list.type;
    NSArray *maleArray =@[@"玄幻",@"奇幻",@"武侠",@"仙侠",@"都市",@"职场",@"历史",@"军事",@"游戏",@"竞技",@"科幻",@"灵异",@"同人",@"轻小说"];
    BOOL isbool = [maleArray containsObject: self.dataStr];
    if (isbool ==1) {
        self.textStr = @"male";
    }else {
        self.textStr = @"female";
    }
    
   
    [self requestData];
 
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.dataArray = [NSMutableArray array];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (void)requestData {
    NSString *urlString = @"http://api.zhuishushenqi.com/book/by-categories?gender=";
    NSString *urlStr = @"&minor=&start=0&limit=50&type=reputation&major=";
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",urlString,_textStr,urlStr,self.dataStr];
    NSString *encodedString = [str URLEncodedString];

    
    [NetWorkRequestManager requestType:GET urlString:encodedString prama:nil success:^(id data) {
        __weak typeof(ReputablyViewController)*reputablyVC = self;
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [dict objectForKey:@"books"];
        for (NSDictionary *dic in array) {
            CommonModel *model = [CommonModel new];
            [model setValuesForKeysWithDictionary:dic];
            [reputablyVC.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue()
                       , ^{
                           [reputablyVC.tableView reloadData];
                           //                           NSLog(@"%@",self.dataArray);
                       });
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.commonModel = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookStoreViewController * bookVC = [[BookStoreViewController alloc] init];
    
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:bookVC];
    naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view.window.rootViewController presentViewController:naVC
                                                      animated:YES completion:nil];
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
