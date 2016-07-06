//
//  LoginViewController.h
//  豆瓣
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef void(^CompletionBlock)(User *user);
@interface LoginViewController : UIViewController

// 登录成功的时候回调
@property (nonatomic, copy) CompletionBlock block;



@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;//用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;    //密码输入框
@property (weak, nonatomic) IBOutlet UIButton *loginButton; //登录按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;  //高约束



@end
