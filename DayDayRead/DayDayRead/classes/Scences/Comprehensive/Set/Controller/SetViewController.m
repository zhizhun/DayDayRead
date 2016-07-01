//
//  SetViewController.m
//  项目
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "SetViewController.h"
#import "SetCell.h"
#import "RESideMenu.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    // Do any additional setup after loading the view.
    [self initView];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //注册cell
    [self.tableView registerClass:[SetCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
        
    }if (section==1) {
        return 4;
    }
    if (section==2) {
        return 6;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
     
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"小说更新提醒";
            cell.rightLabel.text = @"已开启";
         
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"书架排序";
            cell.rightLabel.text = @"最近阅读";
        }
        if (indexPath.row == 1) {
            cell.leftLabel.text = @"书架同步";
            
        }
        if (indexPath.row == 2) {
            cell.leftLabel.text = @"省流量模式 (无头像)";
          
        }
        if (indexPath.row == 3) {
            cell.leftLabel.text = @"夜间模式";
            
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"清理网络缓存";
            cell.rightLabel.text = @"33MB";
        }
        if (indexPath.row == 1) {
            cell.leftLabel.text = @"书籍缓存管理";
            
        }
        if (indexPath.row == 2) {
            cell.leftLabel.text = @"免责声明";
            
        }
        if (indexPath.row == 3) {
            cell.leftLabel.text = @"意见反馈";
            
        }
        if (indexPath.row == 4) {
            cell.leftLabel.text = @"加入我们";
            
        }
        if (indexPath.row == 5) {
            cell.leftLabel.text = @"请赐予我评分";
            
        }
        
    }


    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        UILabel *contentLabel = [[UILabel alloc] init];
//        contentLabel.backgroundColor = [UIColor cyanColor];
//        contentLabel.text = @"11";
//        [self.view addSubview:contentLabel];
//        return contentLabel;
//    }
//    
//    return nil;
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        return @"推送设置";
    }
    
    if (section==1) {
        return @"如需开启/关闭提醒，请在系统的[设置] - [通知中心] 中进行设置通用设置";
    }
    if (section==2) {
       return @"关于我们 V2.25.0";
    }
    return nil;
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
