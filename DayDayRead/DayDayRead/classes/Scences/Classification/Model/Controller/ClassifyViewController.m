//
//  ClassifyViewController.m
//  项目
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 张明杰. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ClassifyCell.h"
#import "HeadReusableView.h"
#import "ClassifyDetailViewController.h"



#define kWith (self.view.bounds.size.width - 40.1)/3

@interface ClassifyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//声明集合视图属性
@property (nonatomic, strong) UICollectionView *collectionView;
// UICollectionViewFlowLayout用来给collectionView布局
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSDictionary *allDataDict;
@property (nonatomic ,strong) NSArray *array;




@end

@implementation ClassifyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    //布局视图
    [self initView];
    [self initLayout];
    
  
   
   
}


- (void)initView {
    
    //定义collectionView的样式
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置item的大小
    self.flowLayout.itemSize = CGSizeMake(kWith, 40);
    //每两个item的最小间距 (垂直滚动)
    self.flowLayout.minimumInteritemSpacing = 10;
   //每两个item的最小间距 (水平滚动)
    self.flowLayout.minimumLineSpacing = 10;
    //设置滚动方向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置视图的内边距 (上左下右)
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //设置头视图的尺寸
    self.flowLayout.headerReferenceSize = CGSizeMake(30, 60);
    // 布局尾视图的尺寸
    self.flowLayout.footerReferenceSize = CGSizeMake(10, 50);

    //创建collectionView并制定样式
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.contentSize = CGSizeMake(0,2000);
    //设置代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.view addSubview:self.collectionView];
    //注册cell
    [self.collectionView registerClass:[ClassifyCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[HeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    // 注册尾视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];

}
- (void)initLayout {
    NSArray *maleArray =@[@"玄幻",@"奇幻",@"武侠",@"仙侠",@"都市",@"职场",@"历史",@"军事",@"游戏",@"竞技",@"科幻",@"灵异",@"同人",@"轻小说"];
    NSArray *femaleArray =@[@"古代言情",@"现代言情",@"青春校园",@"纯爱",@"玄幻奇幻",@"武侠仙侠",@"科幻",@"游戏竞技",@"悬疑灵异",@"同人",@"女尊",@"莉莉"];
    
    self.allDataDict = [NSDictionary dictionaryWithObjects:@[maleArray,femaleArray] forKeys:@[@"男生",@"女生"]];
    self.array = [NSArray arrayWithArray:[self.allDataDict allKeys]];
    
}


//设置分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.array.count;
}
//设置每个分区有多少item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *str = self.array[section];
    NSArray *arr = [self.allDataDict objectForKey:str];
    return arr.count;
}
//返回每个item的cell
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString *str = self.array[indexPath.section];
    NSArray *arr = [self.allDataDict objectForKey:str];
    cell.nameLabel.text = arr[indexPath.row];
    return cell;
    
}
//返回头视图的cell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeadReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.headerLabel.text = @"女生";
        }if (indexPath.section == 1) {
            headerView.headerLabel.text = @"男生";

        }
        
        return headerView;
    }
    UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView" forIndexPath:indexPath];
    footView.backgroundColor = [UIColor whiteColor];
    return footView;

    
}

//点击item事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
        ClassifyDetailViewController *classifyDetail = [[ClassifyDetailViewController alloc] init];
        NSString *str = self.array[indexPath.section];
        NSArray *arr = [self.allDataDict objectForKey:str];
        classifyDetail.textString = arr[indexPath.row];
   
        [self.navigationController pushViewController:classifyDetail animated:YES];

    
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
