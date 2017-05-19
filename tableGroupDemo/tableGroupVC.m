//
//  tableGroupVC.m
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/26.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "tableGroupVC.h"
#import "GroupHeaderView.h"
#import "ChildCell.h"


@interface tableGroupVC ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>

@property (nonatomic,strong) UITableView *groupTable;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *expandArr;

@end

@implementation tableGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.groupTable];
    
    self.title = @"联系人";
}

#pragma mark UITableViewDelegate,UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChildCell"];
    if (!cell) {
        cell = [[ChildCell alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[[[self.dataArr objectAtIndex:indexPath.section] objectForKey:@"childList"] objectAtIndex:indexPath.row]];
    cell.childDic = dic;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.expandArr objectAtIndex:section] integerValue] == 0 ? 0 : [[[self.dataArr objectAtIndex:section] objectForKey:@"childList"] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (1 == section || self.dataArr.count - 1 == section || self.dataArr.count - 3 == section) {
        return 20;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GroupHeaderView *headView = [[GroupHeaderView alloc]initWithFrame:CGRectZero];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[self.dataArr objectAtIndex:section]];
    [dic setObject:[[self.expandArr objectAtIndex:section] integerValue] == 0 ? @"0" : @"1" forKey:@"expandMark"];
    headView.fatherDic = dic;
    headView.delegate = self;
    headView.indexVal = section;
    return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc]init];
    footView.frame = footView.bounds;
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

#pragma mark HeadViewDelegate
-(void)changeExpandStatus:(NSInteger)indexVal status:(BOOL)status
{
    if (status) {
        [self.expandArr replaceObjectAtIndex:indexVal withObject:@1];
    }
    else
    {
        [self.expandArr replaceObjectAtIndex:indexVal withObject:@0];
    }
    [self.groupTable reloadData];
}

#pragma mark 懒加载
-(UITableView *)groupTable
{
    if (!_groupTable) {
        _groupTable = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _groupTable.delegate = self;
        _groupTable.dataSource = self;
        _groupTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _groupTable;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tableGroupData.plist" ofType:nil]];
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

@end
