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
#import "JXLDayAndNightMode.h"


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
    
    
    [_tableView jxl_setDayMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        
        view.backgroundColor = [UIColor blackColor];
        
    }];

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
            
            UISwitch *sw = [[UISwitch alloc] init];
            [sw addTarget: self action: @selector(imageViewChanged:) forControlEvents: UIControlEventValueChanged];
            sw.frame = CGRectMake(0, 0, 80, 40);
              cell.accessoryView = sw;

            [cell.contentView addSubview: sw];

          
        }
        if (indexPath.row == 3) {
            cell.leftLabel.text = @"夜间模式";
            
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
            if (JXLDayAndNightModeDay == [[JXLDayAndNightManager shareManager] contentMode]) {
                switchView.on = NO;
            } else {
                switchView.on = YES;
            }
          cell.accessoryView = switchView;
            [switchView addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
            
        }
        
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"清理网络缓存";
            cell.rightLabel.text = @"0MB";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:{
                
                
                break;
            }
            case 3:
                
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:{
                [self clearAllCache];
                break;
            }
            case 1:{
            }
                break;
              
            case 2:{
                UIAlertController *alertView= [UIAlertController alertControllerWithTitle:@"免责声明" message:nil preferredStyle:UIAlertControllerStyleAlert];
               alertView.message = @"天天追书提醒您：在使用天天追书前，请您务必自诩阅读并透彻理解本声明。您可以选择不使用天天追书，但如果还有，您的使用行为将视为对本声明全部内容的认可 天天追书是一款提供网络小说即时更新的工具，为广大小说爱好者提供一种方便、快捷、舒适的试读体验。天天煮熟致力于最大程度的减少网络小说与读者在自行搜寻过程中毫无意义的时间浪费，通过专业搜索展示不同网站中网络小说的最新章节。天天追书为广大小说爱好者提供方便、跨界、舒适体验的同时，也使优秀网络小说得以更迅捷、更广泛的传播，从而达到了在一定程度促进网络文学充分繁荣发展之目的。";

                                UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];

                [alertView addAction:action2];
                [self presentViewController:alertView animated:YES completion:nil];
              
                break;
            }
            case 3:{
                
                break;
            }
            case 4:{
                
                break;
            }
            case 5:{
                
                break;
            }

                default:
                break;
        }

    }
}

//夜间模式
- (void)switchValueChange:(UISwitch *)switchView {
    if (switchView.on) {
        
        [[JXLDayAndNightManager shareManager] nightMode];
    } else {
        [[JXLDayAndNightManager shareManager] dayMode];
    }
}


#pragma mark - 自定义方法
#pragma mark 清理缓存
- (void)clearAllCache
{
#warning 清除缓存，真正执行的代理，放在了alerView的代理方法中
    // 弹框警告
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定清理缓存吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma mark - UIAlertViewDelegate Method
#pragma mark 处理alertView的点击
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
