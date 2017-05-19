//
//  DetailCell.m
//  tableGroupDemo
//
//  Created by 易博 on 2017/4/28.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "DetailCell.h"

@interface DetailCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation DetailCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil][0];
        self.frame = frame;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    self.titleLabel.text = [dataDic objectForKey:@"title"];
    self.detailLabel.text = [dataDic objectForKey:@"detail"];
}

@end
