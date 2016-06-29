//
//  ListViewController.m
//  DayDayRead
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 DayDayRead. All rights reserved.
//

#import "ListViewController.h"
#import "HotViewController.h"
#import "RemainViewController.h"
#import "EndViewController.h"
#import "PotentialViewController.h"
#import "WHotViewController.h"
#import "WRemainViewController.h"
#import "WEndViewController.h"
#import "WPotentialViewController.h"
@interface ListViewController ()

@property (nonatomic, strong) NSMutableArray *listArray;



@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    [self initLayout];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)initLayout {
    
    self.listArray = [NSMutableArray array];
    [self.listArray addObjectsFromArray:@[
                                          @{@"nameImage":@"person@2x",
                                            @"name":@"追书最热榜Top100"},
                                          @{@"nameImage":@"person@2x",
                                            @"name":@"读者留存率Top100"},
                                          @{@"nameImage":@"person@2x",
                                            @"name":@"追书完结榜Top100"},
                                          @{@"nameImage":@"person@2x",
                                            @"name":@"本周潜力榜"}
                                          ]];
    
    
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

    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.listArray[indexPath.row][@"name"];
    cell.imageView.image = [UIImage imageNamed:self.listArray[indexPath.row][@"nameImage"]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
       
        [button setTitle:@"男生" forState:UIControlStateNormal];
        
        button.tintColor = [UIColor grayColor];
        button.backgroundColor = [UIColor lightGrayColor];
        return button;
    } else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"女生" forState:UIControlStateNormal];
        button.tintColor = [UIColor grayColor];
        button.backgroundColor = [UIColor lightGrayColor];
        return button;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                HotViewController *hotVC = [[HotViewController alloc] init];
                [self.navigationController pushViewController:hotVC animated:YES];
            }
                break;
            case 1: {
                RemainViewController *remainVC = [[RemainViewController alloc] init];
                [self.navigationController pushViewController:remainVC animated:YES];
            }
                break;
            case 2: {
                EndViewController *endVC = [[EndViewController alloc] init];
                [self.navigationController pushViewController:endVC animated:YES];
            }
                break;
            case 3: {
                PotentialViewController *potenVC = [[PotentialViewController alloc] init];
                [self.navigationController pushViewController:potenVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                WHotViewController *hotVC = [[WHotViewController alloc] init];
                [self.navigationController pushViewController:hotVC animated:YES];
            }
                break;
            case 1: {
                WRemainViewController *remainVC = [[WRemainViewController alloc] init];
                [self.navigationController pushViewController:remainVC animated:YES];
            }
                break;
            case 2: {
                WEndViewController *endVC = [[WEndViewController alloc] init];
                [self.navigationController pushViewController:endVC animated:YES];
            }
                break;
            case 3: {
                WPotentialViewController *potentialVC = [[WPotentialViewController alloc] init];
                [self.navigationController pushViewController:potentialVC animated:YES];
            }
                break;
            default:
                break;
        }
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
