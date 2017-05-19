//
//  FatherCell.m
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/26.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "FatherCell.h"

@interface FatherCell()
//左侧的小三角
@property (weak, nonatomic) IBOutlet UIImageView *markImage;
//组名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//组成员数量
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation FatherCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"FatherCell" owner:nil options:nil][0];
        self.frame = frame;
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.separatorInset = insets;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setFatherDic:(NSDictionary *)fatherDic
{
    self.nameLabel.text = [fatherDic objectForKey:@"fatherName"] ? [NSString stringWithFormat:@"%@",[fatherDic objectForKey:@"fatherName"]] : @"";
    self.countLabel.text = [fatherDic objectForKey:@"childList"] ? [NSString stringWithFormat:@"%lu",[[fatherDic objectForKey:@"childList"] count]] : @"0";
    
    if(0 == [[fatherDic objectForKey:@""] integerValue])
    {
        self.markImage.image = [UIImage imageNamed:@"right"];
    }
    else
    {
        self.markImage.image = [UIImage imageNamed:@"down"];
    }
}

-(void)setExpandStatus:(NSInteger )status
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((0 == status ? 0.5 : 0) * M_PI);
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.markImage.transform = endAngle;
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
