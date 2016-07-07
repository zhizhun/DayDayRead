//
//  MyInformationViewController.m
//  项目
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "MyInformationViewController.h"
#import "MyInformationCell.h"
#import "HeadPortraitViewController.h"
#import "NickNameViewController.h"
#import <Masonry.h>


@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong) UIImagePickerController *imagePicker; //图片选择器


@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑资料";
    
    [self initView];
    self.dataArray = [NSMutableArray array];
}

- (void)initView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    //注册cell
    
    [self.tableView registerClass:[MyInformationCell class] forCellReuseIdentifier:@"cell"];

    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        if (indexPath.row == 0) {
            cell.contentLabel.text = @"修改头像";
            cell.imageView1.image = [UIImage imageNamed:@"1.jpg"];
            return cell;
        }
        if (indexPath.row == 1) {
            cell.contentLabel.text = @"修改昵称";
           cell.contentLabel1.text = @"";
            return cell;
        }
        if (indexPath.row == 2) {
            cell.contentLabel.text = @"性别";
            cell.contentLabel1.text = @"男";
            return cell;
        }
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
//              HeadPortraitViewController *headVc = [[HeadPortraitViewController alloc] init];
//        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:headVc];
//        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self.view.window.rootViewController presentViewController:naVC
//                                                          animated:YES completion:nil];
        //调用系统相册 相机
        //添加alartSheet
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //指定资源类型
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            _imagePicker.allowsEditing = YES;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            
            
        }];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _imagePicker.allowsEditing = YES;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            
            
        }];
        UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:photoAction];
        [alert addAction:cameraAction];
        [alert addAction:canAction];
        //显示alertController
        [self presentViewController:alert animated:YES completion:nil];

    }
    if (indexPath.row == 1) {
        
        NickNameViewController *nickVC = [[NickNameViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:nickVC];
        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        nickVC.block = ^void(NSString *textString) {
            MyInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.contentLabel.text = @"修改昵称";
            cell.contentLabel1.text = textString;
        
        };
        [self presentViewController:naVC                                                         animated:YES completion:nil];
    }
    if (indexPath.row == 2) {
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择你的性别" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *canAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:canAction];
[self presentViewController:alert animated:YES completion:nil];
    }
    
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
