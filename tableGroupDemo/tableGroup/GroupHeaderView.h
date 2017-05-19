//
//  GroupHeaderView.h
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/28.
//  Copyright © 2017年 易博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate <NSObject>

-(void)changeExpandStatus:(NSInteger)indexVal status:(BOOL)status;

@end

@interface GroupHeaderView : UIView

//数据源
@property (nonatomic,strong) NSDictionary *fatherDic;

//代理
@property (nonatomic,assign) id<HeadViewDelegate> delegate;

//当前headview的索引
@property (nonatomic,assign) NSInteger indexVal;

@end
