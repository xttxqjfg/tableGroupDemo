//
//  ChildCell.m
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/26.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "ChildCell.h"

@interface ChildCell()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//状态
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ChildCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ChildCell" owner:nil options:nil][0];
        self.frame = frame;
    }
    return self;
}

-(void)setChildDic:(NSDictionary *)childDic
{
    self.leftImageView.image = [UIImage imageNamed:@"11"];
    self.leftImageView.layer.cornerRadius = 22.0;
    self.leftImageView.layer.masksToBounds = YES;
    
    self.nameLabel.text = [childDic objectForKey:@"childName"] ? [NSString stringWithFormat:@"%@",[childDic objectForKey:@"childName"]] : @"";
    self.statusLabel.text = [childDic objectForKey:@"childStatus"] ? [NSString stringWithFormat:@"%@",[childDic objectForKey:@"childStatus"]] : @"";
}

@end
