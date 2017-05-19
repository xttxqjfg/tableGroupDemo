//
//  replaceVC.m
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/28.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "replaceVC.h"
#import "TitleCell.h"
#import "DetailCell.h"

@interface replaceVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *replaceTable;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@property (nonatomic,strong) NSIndexPath *preSelectedIndexPath;

@property (nonatomic,strong) NSMutableArray *expandArr;

@end

@implementation replaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.replaceTable];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [[NSDictionary alloc]initWithDictionary:[self.dataArr objectAtIndex:indexPath.row]];
    /*
    //整个表只展示一个cell，其余的收起
    if (self.selectedIndexPath != indexPath) {
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
        if (!cell) {
            cell = [[TitleCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        cell.dataDic = dic;
        return cell;
    }
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if (!cell) {
        cell = [[DetailCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    cell.dataDic = dic;
    return cell;
    */
    
    NSInteger status = [[self.expandArr objectAtIndex:indexPath.row] integerValue];
    
    NSLog(@"++++++++++++:%ld",(long)status);
    
    if (0 == status) {
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
        if (!cell) {
            cell = [[TitleCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        cell.dataDic = dic;
        return cell;
    }
    
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if (!cell) {
        cell = [[DetailCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    cell.dataDic = dic;
    return cell;
     
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    //整个表只展示一个cell，其余的收起
    self.preSelectedIndexPath = self.selectedIndexPath;
    self.selectedIndexPath = indexPath;
    
    [tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (self.preSelectedIndexPath) {
        [tableView reloadRowsAtIndexPaths:@[self.preSelectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
//    [tableView scrollToRowAtIndexPath:self.selectedIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
     */
    
    
    [self changeExpandArrAtIndexPath:indexPath];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     //整个表只展示一个cell，其余的收起
    if(self.selectedIndexPath != indexPath)
    {
        return 50;
    }
    return 200;
     */
    
    
    NSInteger status = [[self.expandArr objectAtIndex:indexPath.row] integerValue];
    
    if(0 == status)
    {
        return 50;
    }
    return 200;
    
}

#pragma mark pivate
-(void)changeExpandArrAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger status = [[self.expandArr objectAtIndex:indexPath.row] integerValue];
    if (0 == status) {
        [self.expandArr replaceObjectAtIndex:indexPath.row withObject:@1];
    }
    else
    {
        [self.expandArr replaceObjectAtIndex:indexPath.row withObject:@0];
    }
}

#pragma mark 懒加载
-(UITableView *)replaceTable
{
    if (!_replaceTable) {
        _replaceTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _replaceTable.delegate = self;
        _replaceTable.dataSource = self;
        [_replaceTable registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
        [_replaceTable registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"DetailCell"];
    }
    return _replaceTable;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"replaceData.plist" ofType:nil]];
    }
    return _dataArr;
}

-(NSMutableArray *)expandArr
{
    if (!_expandArr) {
        _expandArr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in self.dataArr) {
            [_expandArr addObject:@0];
        }
    }
    return _expandArr;
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
