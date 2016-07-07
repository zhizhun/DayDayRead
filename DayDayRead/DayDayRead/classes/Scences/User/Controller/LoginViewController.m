//
//  LoginViewController.m
//  豆瓣
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import <AFNetworking.h>
#import "UserFileHandle.h"
#import "User.h"
#import "URL.h"
#import "RootViewController.h"
#import "UserFileHandle.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航状态栏
    [self setNavandStatus];
}
//设置导航状态栏
- (void)setNavandStatus{
    self.title = @"我";
    //取消透明
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (IBAction)goToRegist:(id)sender {
    
   
    RegistViewController *registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}



- (IBAction)loginAction:(id)sender {
    
        __weak LoginViewController *loginVC = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([alertController.message isEqualToString:@"登录成功"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertController addAction:action];
    // 判断用户名密码是否为空
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]) {
        alertController.message = @"用户名或密码不能为空";
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //设置参数
        NSDictionary * dicParam = @{@"userName":_userNameTextField.text,@"password":_passwordTextField.text};
        [manager POST:USER_LOGIN_URL parameters:dicParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            //解析返回结果
            if ([responseObject[@"success"] intValue] == 1) {
                //生成一个User对象
                User * user = [User new];
                NSDictionary * dic = responseObject[@"data"];
                [user setValuesForKeysWithDictionary:dic];
                user.userName = _userNameTextField.text;
                user.password = _passwordTextField.text;
                user.isLogin = YES;
                //将当前用户的信息存储到本地
                [UserFileHandle saveUserInfo:user];
                alertController.message = @"登录成功";
                //传值
                loginVC.block(user);
                
            }else{
                if ([responseObject[@"code"] intValue] == 1102) {
                    alertController.message = @"登录用户不存在";
                }else{
                    alertController.message = @"登录失败";
                }
            }
            
            [loginVC presentViewController:alertController animated:YES completion:nil];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            alertController.message = @"请求失败";
            [loginVC presentViewController:alertController animated:YES completion:nil];
        }];
        
    }
    
    

}

/**
 * 点击空白处执行此方法
 */
- (IBAction)tapEmpty:(id)sender {
    //键盘回收
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}


#pragma mark - UITextFeld Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //键盘回收
    return [_passwordTextField resignFirstResponder] | [_userNameTextField resignFirstResponder];
}

- (IBAction)logoutAction:(id)sender {
    
    __weak typeof(self)weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注销" message:@"确定要注销吗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [UserFileHandle deleteUserInfo];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
