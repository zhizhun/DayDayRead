//
//  RegistViewController.m
//  豆瓣
//
//  Created by lanou3g on 16/6/20.
//  Copyright © 2016年 王治庭. All rights reserved.
//

#import "RegistViewController.h"
#import "URL.h"
#import <AFNetworking.h>
@interface RegistViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;  //头像
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;    //用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;    //密码输入框
@property (weak, nonatomic) IBOutlet UITextField *repasswordTextField;  //重复密码
@property (nonatomic, strong) UIImagePickerController *imagePicker; //图片选择器

@property (weak, nonatomic) IBOutlet UIButton *registerButton;  //注册按钮

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;  //高约束



@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.passwordTextField.delegate = self;
    self.userNameTextField.delegate = self;
    self.repasswordTextField.delegate = self;
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 赋值头像
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    _avatarImageView.image = image;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    
    // dismiss当前选择的页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //隐藏图片选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage {
    NSLog(@"存储图片。。。");
}

// 点击头像的方法
- (IBAction)imageTapAction:(id)sender {
    // 调用系统相册相机
    //添加AlertSheet
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //指定资源类型
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:cancleAction];
    
    //显示alertController
    [self presentViewController:alert animated:YES completion:nil];
    
}

/**
 * 点击空白处执行此方法
 */
- (IBAction)tapEmpty:(id)sender {
    
    
}


- (IBAction)registerAction:(id)sender {
    __weak RegistViewController * registerVC = self;
    
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if ([alertController.message isEqualToString:@"注册成功"]) {
            [registerVC.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertController addAction:cancleAction];
    
    if ([_userNameTextField.text isEqualToString:@""]) {
        alertController.message = @"用户名不能为空";
    }else if ([_passwordTextField.text isEqualToString:@""]){
        alertController.message = @"密码不能为空";
    }else if(![_repasswordTextField.text isEqualToString:_passwordTextField.text]){
        alertController.message = @"两次密码输入不一致";
    }else{
        //发起网络请求，上传用户名、密码和头像
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        //参数
        NSDictionary * param = @{@"userName":_userNameTextField.text,@"password":_passwordTextField.text};
        [manager POST:USER_REGISTER_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(_avatarImageView.image, 0.5) name:@"avatar" fileName:@"avatar.jpg" mimeType:@"application/octet-stream"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"success"] intValue] == 1) {
                alertController.message = @"注册成功";
                
                [self presentViewController:alertController animated:YES completion:^{
                    
                }];
                
            }else{
                if ([responseObject[@"code"] intValue] == 1002) {
                    alertController.message = @"用户名已存在";
                    
                }else{
                    alertController.message = @"注册失败";
                }
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            alertController.message = @"请求失败";
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
    
    
    
    
    
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
     NSLog(@"------");
    return [_userNameTextField resignFirstResponder] | [_passwordTextField resignFirstResponder] | [_repasswordTextField resignFirstResponder];
   
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
