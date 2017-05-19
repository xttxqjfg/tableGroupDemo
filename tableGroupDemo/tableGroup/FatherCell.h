//
//  FatherCell.h
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/26.
//  Copyright © 2017年 易博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FatherCell : UITableViewCell

//数据源
@property (nonatomic,strong) NSDictionary *fatherDic;

//设置分组展开或者收缩时小三角
-(void)setExpandStatus:(NSInteger )status;

@end
