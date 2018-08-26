//
//  DSParkTableViewCell.m
//  DSTaipeiParks
//
//  Created by Dolphin Su on 2018/8/25.
//  Copyright © 2018 Dolphin Su. All rights reserved.
//

#import "DSParkTableViewCell.h"

@interface DSParkTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *parkNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *introductionLabel;
@end

@implementation DSParkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)prepareForReuse
{
    [super prepareForReuse];
    _parkNameLabel.text = nil;
    _introductionLabel.text = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureParkName:(nonnull NSString *)parkName introduction:(nonnull NSString *)introduction
{
    _parkNameLabel.text = parkName;
    _introductionLabel.text = introduction;
}
@end
