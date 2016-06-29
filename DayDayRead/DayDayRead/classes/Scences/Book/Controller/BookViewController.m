//
//  BookViewController.m
//  TTZS
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "BookViewController.h"
#import "BookAllCell.h"
#import "BookView.h"
#import "BookHeaderView.h"
#import "BookAllViewController.h"
#import "SingletonBook.h"
@interface BookViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) BookView *bookView;

@property (nonatomic, strong) NSDictionary *allDict;

@property (nonatomic, strong) NSArray *keyArr;

@property (nonatomic, strong) NSArray *valueArr;

@property (nonatomic, strong) NSString *string;



@end

@implementation BookViewController

- (void)loadView {
    
    self.bookView = [[BookView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.bookView;
    self.view.backgroundColor = [UIColor whiteColor];
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局
    [self initLayout];
    
    
   
    self.title = @"筛选书单";
    // 设置代理
    self.bookView.collectionView.delegate = self;
    self.bookView.collectionView.dataSource = self;
    
    // 注册
    [self.bookView.collectionView registerClass:[BookAllCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 注册头视图
    [self.bookView.collectionView registerClass:[BookHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    
}

- (void)initLayout {
    
    NSArray *arr1 = @[@"全部书单"];
    NSArray *arr2 = @[@"男生", @"女生"];
    NSArray *arr3 = @[@"都市", @"古代", @"科幻", @"架空", @"重生", @"未来", @"穿越", @"历史", @"快穿", @"末世", @"异界位面"];
    NSArray *arr4 = @[@"纯爱", @"热血", @"言情", @"现言", @"古言", @"情有独钟", @"搞笑", @"青春", @"欢喜冤家", @"爽文", @"虐文"];
    NSArray *arr5 = @[@"变身", @"悬疑", @"系统", @"网游", @"推理", @"玄幻", @"武侠", @"仙侠", @"恐怖", @"奇幻", @"洪荒", @"犯罪", @"百合", @"种田", @"惊悚", @"轻小说", @"技术流", @"耽美", @"竞技", @"无限"];
    NSArray *arr6 =  @[@"同人", @"娱乐明星", @"女强", @"帝王", @"职场", @"女配", @"网配", @"火影", @"金庸", @"豪门", @"扮猪吃虎", @"谋士", @"特种兵", @"教师"];
     self.valueArr = @[arr1,arr2,arr3,arr4,arr5,arr6];
     self.keyArr = @[@"全部", @"性别", @"时空", @"情感", @"流派", @"人设"];
     self.allDict = [NSDictionary dictionaryWithObjects:self.valueArr forKeys:self.keyArr];
     //self.array = [NSArray arrayWithArray:[self.allDict allKeys]];
    
}


//section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.keyArr.count;
}

//每个分区item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *arr = [self.allDict objectForKey:self.keyArr[section]];
    return arr.count;
    
}

//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookAllCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *arr = [self.allDict objectForKey:self.keyArr[indexPath.section]];
    cell.label.text = arr[indexPath.row];
    
    
   
   
    
    return cell;
}


//每个section的头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    BookHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.label.text = self.keyArr[indexPath.section];
    
   
    return header;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookAllCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *arr = [self.allDict objectForKey:self.keyArr[indexPath.section]];
    cell.label.text = arr[indexPath.row];
    

    self.block(cell.label.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
