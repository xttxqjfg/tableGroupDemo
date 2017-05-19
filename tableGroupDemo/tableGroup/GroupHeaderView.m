//
//  GroupHeaderView.m
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/28.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "GroupHeaderView.h"

@interface GroupHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *expandImage;
@property (nonatomic,assign) BOOL expandMark;
@end

@implementation GroupHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"GroupHeaderView" owner:nil options:nil][0];
        self.frame = frame;
        
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)setFatherDic:(NSDictionary *)fatherDic
{
    self.titleLabel.text = [fatherDic objectForKey:@"fatherName"] ? [NSString stringWithFormat:@"%@",[fatherDic objectForKey:@"fatherName"]] : @"";
    self.countLabel.text = [fatherDic objectForKey:@"childList"] ? [NSString stringWithFormat:@"%lu",[[fatherDic objectForKey:@"childList"] count]] : @"0";
    
    if(0 == [[fatherDic objectForKey:@"expandMark"] integerValue])
    {
        self.expandImage.image = [UIImage imageNamed:@"right"];
        self.expandMark = NO;
    }
    else
    {
        self.expandImage.image = [UIImage imageNamed:@"down"];
        self.expandMark = YES;
    }
}

-(void)viewTaped:(UITapGestureRecognizer *)sender
{
    if (self.expandMark) {
        //收起
        self.expandMark = NO;
        [self setExpandStatus:NO];
    }
    else
    {
        //展开
        self.expandMark = YES;
        [self setExpandStatus:YES];
    }
    
    
}

-(void)setExpandStatus:(BOOL)status
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((YES == status ? 0.5 : 0) * M_PI);
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.expandImage.transform = endAngle;
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(changeExpandStatus:status:)]) {
            [self.delegate changeExpandStatus:self.indexVal status:self.expandMark];
        }
        
    }];
}

@end
